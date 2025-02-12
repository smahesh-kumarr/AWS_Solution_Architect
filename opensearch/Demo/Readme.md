# AWS OpenSearch Setup for EC2 Logs Analysis

## **Overview**
This guide explains how to send logs from an **EC2-hosted website** to **CloudWatch**, then forward them to **Amazon OpenSearch Service** for **log analysis, security monitoring, and full-text search**.

## **Architecture**
1. **EC2 Instance**: Hosts your product-selling website (like Amazon or Flipkart).
2. **CloudWatch Logs**: Collects application and system logs from EC2.
3. **Kinesis Firehose**: Transfers logs from CloudWatch to OpenSearch.
4. **Amazon OpenSearch**: Stores and analyzes logs using search queries.

---

## **Step 1: Configure CloudWatch Logs for EC2**
1. **Install CloudWatch Logs Agent** (if not already installed):
   ```bash
   sudo yum install -y amazon-cloudwatch-agent
   sudo systemctl enable amazon-cloudwatch-agent
   sudo systemctl start amazon-cloudwatch-agent
   ```
2. **Create CloudWatch Log Group:**
   ```bash
   aws logs create-log-group --log-group-name "/aws/ec2/my-ecommerce-logs"
   ```
3. **Configure the CloudWatch Agent:**
   ```bash
   sudo nano /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
   ```
   **Example Configuration:**
   ```json
   {
     "logs": {
       "logs_collected": {
         "files": {
           "collect_list": [
             {
               "file_path": "/var/log/nginx/access.log",
               "log_group_name": "/aws/ec2/my-ecommerce-logs"
             }
           ]
         }
       }
     }
   }
   ```
4. **Restart the CloudWatch Agent:**
   ```bash
   sudo systemctl restart amazon-cloudwatch-agent
   ```

---

## **Step 2: Create a Kinesis Firehose Stream**
1. **Go to AWS Console** → **Kinesis** → **Firehose**
2. Click **Create Delivery Stream**
3. **Source**: Select **Direct PUT**
4. **Destination**: Choose **Amazon OpenSearch Service**
5. **Enter OpenSearch Domain Endpoint**
6. **Index Name**: `ec2-logs`
7. Click **Create Delivery Stream**

---

## **Step 3: Connect CloudWatch to Kinesis Firehose**
Run the following AWS CLI command to set up log streaming:
```bash
aws logs put-subscription-filter \
  --log-group-name "/aws/ec2/my-ecommerce-logs" \
  --filter-name "EC2LogFilter" \
  --filter-pattern "" \
  --destination-arn "arn:aws:firehose:us-east-1:123456789012:deliverystream/ec2-log-stream"
```
✔️ Now, CloudWatch will send logs to OpenSearch!

---

## **Step 4: Verify Logs in OpenSearch**
1. **Go to OpenSearch Dashboards (Kibana UI)**
2. Click **Index Management**
3. Search for `ec2-logs` to confirm logs are arriving

---

## **Step 5: Searching Logs in OpenSearch**

🔍 **Find HTTP 500 Errors:**
```json
GET ec2-logs/_search
{
  "query": {
    "match": {
      "status": "500"
    }
  }
}
```

🔍 **Find Failed Logins:**
```json
GET ec2-logs/_search
{
  "query": {
    "match": {
      "message": "Failed password"
    }
  }
}
```

---

## **Why This Approach is Better Than Logstash?**
✅ **Serverless** – No need to manage Logstash.
✅ **Fully Managed** – AWS handles scaling and failures.
✅ **Better Integration** – Works seamlessly with AWS services.
