# Amazon Kinesis - Detailed Notes

Amazon Kinesis is a **real-time data streaming service** that helps ingest, process, and analyze large volumes of data continuously. It provides four key services:
- **Kinesis Data Streams (KDS)**: Real-time data ingestion and processing.
- **Kinesis Data Firehose**: Automated delivery to AWS services.
- **Kinesis Data Analytics**: Real-time SQL-based analytics on streaming data.
- **Kinesis Video Streams**: Streaming video data to AWS.

---

## 1. Amazon Kinesis Data Streams (KDS)
Kinesis Data Streams is a scalable service that allows applications to collect, process, and analyze streaming data in real-time.

### Key Components:
- **Producers**: Send data to Kinesis (e.g., IoT devices, logs, clickstreams).
- **Shards**: Basic unit of capacity in a stream; stores and manages incoming records.
- **Consumers**: Read data from shards for real-time analytics.
- **Retention**: Stores data for **24 hours** (default) or **7 days** (extended).

### Workflow:
1. **Producers** (e.g., application logs, IoT devices) send data to Kinesis.
2. **Shards** distribute the data based on a **partition key**.
3. **Consumers** (e.g., AWS Lambda, EC2, Kinesis Analytics) process the data.

### Example Use Case:
A stock trading application sends real-time stock price updates to Kinesis. Consumers process the data for fraud detection and trend prediction.

---

## 2. Amazon Kinesis Data Firehose
A fully managed service that **delivers streaming data** to AWS services like Amazon S3, Redshift, OpenSearch, and Splunk without manual intervention.

### Key Features:
- **Automatic scaling** (no need to manage shards).
- **Data transformation** using AWS Lambda.
- **Compression & Encryption** for efficient storage.
- **Partitioning & Dynamic Partitioning** to organize data efficiently.

### Workflow:
1. **Producers** (IoT devices, applications) send data to Firehose.
2. **Firehose buffers** the data before processing.
3. **Transformation (optional)**: AWS Lambda cleans, filters, and formats data.
4. **Delivery**: Firehose sends data to S3, Redshift, OpenSearch, or Splunk.

### Example Use Case:
A **web application** streams user activity logs to Firehose, which processes and loads data into **Amazon Redshift** for analytics.

---

## 3. Amazon Kinesis Data Analytics
A service that allows you to run **real-time SQL queries** on streaming data.

### Key Features:
- **SQL-based stream processing**
- **Integration with Kinesis Data Streams & Firehose**
- **Windowing operations** to analyze time-based data trends

### Workflow:
1. **Data from Kinesis Data Streams** is continuously processed.
2. **SQL queries** filter, transform, and aggregate data.
3. **Output is sent** to Firehose, S3, or another data store.

### Example Use Case:
A manufacturing company monitors **sensor data** from machines in real-time to detect anomalies and trigger maintenance alerts.

---

## 4. Amazon Kinesis Video Streams
Kinesis Video Streams captures, processes, and stores video streams for real-time or batch analysis.

### Key Features:
- **Live video ingestion** from cameras, drones, and security devices.
- **Integration with AI/ML services** (e.g., Amazon Rekognition for facial recognition).
- **Secure data encryption** using AWS KMS.

### Workflow:
1. **Video sources** (IP cameras, IoT devices) send streams to Kinesis.
2. **Kinesis stores the video securely**.
3. **AWS AI services** analyze the video for object detection, facial recognition, etc.

### Example Use Case:
A smart home system uses **Kinesis Video Streams** to detect and notify homeowners about movement detected by security cameras.

---

## Comparison: Kinesis Data Streams vs. Firehose
| Feature              | Kinesis Data Streams | Kinesis Data Firehose |
|---------------------|---------------------|----------------------|
| **Use Case**       | Real-time processing | Automated delivery |
| **Shards Required** | Yes (manual scaling) | No (auto-scaling) |
| **Processing**      | Requires consumer apps | No need for consumers |
| **Transformation**  | Requires manual processing | AWS Lambda integration |
| **Destinations**    | EC2, Lambda, Analytics | S3, Redshift, OpenSearch |

---

## Partitioning & Dynamic Partitioning in Firehose
Partitioning **helps organize data efficiently** when storing it in Amazon S3 or Redshift.

### Static Partitioning:
- Data is written into **a single partition** (folder) without categorization.
- Example: `s3://my-bucket/logs/2024/02/23/`

### Dynamic Partitioning:
- Firehose automatically organizes data into **separate folders** based on attributes (e.g., region, event type).
- Example:  

s3://my-bucket/logs/region=US/2024/02/23/ s3://my-bucket/logs/region=EU/2024/02/23/

- **Benefits:** Faster queries and reduced storage costs.

---

## Conclusion
- **Kinesis Data Streams**: Best for real-time data processing.
- **Kinesis Firehose**: Best for automatic data delivery.
- **Kinesis Analytics**: SQL-based real-time analysis.
- **Kinesis Video Streams**: Live and recorded video processing.

---

# AWS Kinesis Data Firehose Data Transformation with AWS Lambda

## Overview
AWS Kinesis Data Firehose allows real-time streaming of data into AWS storage and analytics services. Firehose supports data transformation using AWS Lambda before delivering data to its final destination.

## How It Works
1. **Data Ingestion:** Firehose receives data from a producer (e.g., IoT devices, application logs).
2. **Lambda Transformation:** Firehose invokes an AWS Lambda function to process the data.
3. **Error Handling:** Failed transformations are stored in an S3 backup bucket.
4. **Data Delivery:** The transformed data is stored in S3, Redshift, or Elasticsearch.

## Example Use Case
Transform raw CSV data into JSON before storing it in an S3 bucket.

## Steps to Implement
### 1. Create a Firehose Delivery Stream
- Go to AWS **Kinesis Data Firehose**
- Click **Create Delivery Stream**
- Select source: **Direct PUT or Kinesis Stream**
- Choose destination: **Amazon S3**
- Enable **Data Transformation** and select **AWS Lambda**

### 2. Create a Lambda Function for Transformation
Use the following Python code in AWS Lambda:

```python
import json

def lambda_handler(event, context):
    output_records = []
    
    for record in event['records']:
        # Decode base64 data from Firehose
        raw_data = record['data']
        decoded_data = raw_data.decode('utf-8')
        
        # Transform CSV to JSON (assuming CSV format: id,name,age)
        fields = decoded_data.strip().split(',')
        transformed_data = {
            "id": fields[0],
            "name": fields[1],
            "age": int(fields[2])
        }
        
        # Encode transformed data back to base64 for Firehose
        transformed_payload = json.dumps(transformed_data) + "\n"
        encoded_data = transformed_payload.encode('utf-8')
        
        output_records.append({
            'recordId': record['recordId'],
            'result': 'Ok',
            'data': encoded_data
        })
    
    return {'records': output_records}
```

### 3. Attach Lambda to Firehose
- Select your Lambda function in the **Data Transformation** section.
- Configure **Buffer Interval** (default: 60 seconds).
- Define a **Backup S3 Bucket** for failed transformations.
- Save and deploy the Firehose stream.

### 4. Monitor and Debug
- Use **AWS CloudWatch** logs for monitoring.
- Check the **S3 backup bucket** for failed records.

## Summary
- Firehose can transform data **before storing it** in AWS services.
- **AWS Lambda** modifies the data, such as changing formats and filtering fields.
- **S3 Backup** stores untransformed records for debugging.

This setup ensures efficient, real-time data processing with error handling and monitoring.


# AWS Kinesis Data Firehose - Dynamic Partitioning

## Overview
Dynamic Partitioning in AWS Kinesis Data Firehose enables the **automatic grouping of streaming data** based on specific keys before delivering it to **Amazon S3**. This helps improve query performance, reduce costs, and optimize analytics for services like **Amazon Athena, Redshift Spectrum, and AWS Glue**.

## How Partitioning Works
Partitioning organizes data into separate directories or keys based on attributes like **date, region, user ID**, etc. For example:
```
s3://my-bucket/data/year=2025/month=02/day=24/
```
This structure helps in efficient data retrieval and analysis.

## Dynamic Partitioning in Firehose
Dynamic Partitioning takes traditional partitioning a step further by **automatically** extracting partition keys from streaming data and grouping data accordingly.

### **How It Works**
1. **Partition Key Selection:**
   - **Inline Partitioning:** Uses a **JQ expression** to extract partition keys from JSON data.
   - **Lambda Function:** Uses AWS Lambda to process records and extract partition keys dynamically.

2. **Data Grouping & Delivery:**
   - Firehose groups data by extracted partition keys.
   - The grouped data is delivered to Amazon S3 with **folder prefixes** representing partition keys.

### **Example of S3 Folder Structure**
```
s3://my-bucket/logs/event_type=clicks/year=2025/month=02/day=24/
s3://my-bucket/logs/event_type=purchases/year=2025/month=02/day=24/
```

## Benefits of Dynamic Partitioning
✅ **Automated Organization** – No need for manual partitioning setup.  
✅ **Optimized Query Performance** – Reduces data scanning, making queries faster.  
✅ **Cost-Effective** – Minimizes AWS Athena and Redshift query costs.  
✅ **AWS Glue Integration** – Enhances ETL (Extract, Transform, Load) jobs.

## Key Considerations
- 🔹 **Once enabled, Dynamic Partitioning cannot be turned off** for a Firehose stream.
- 🔹 Requires an **Amazon S3 destination**.
- 🔹 **Cost Consideration:** Higher partition counts may increase processing costs.

## Conclusion
- **Partitioning** helps structure data for better analytics.
- **Dynamic Partitioning in Firehose** automates partitioning and optimizes data delivery.
- **Best for** high-volume streaming data with complex analytical needs.

---
🔥 **Leverage AWS Firehose with Dynamic Partitioning for scalable and cost-efficient data processing!** 🚀
