# AWS ECS & Fargate Guide

## Introduction
Amazon ECS (Elastic Container Service) is a fully managed container orchestration service that allows you to run and manage Docker containers. AWS Fargate is a serverless compute engine for ECS that eliminates the need to manage EC2 instances for container workloads.

---

## **ECS vs Fargate**
| Feature              | ECS (EC2 Launch Type) | Fargate (Serverless) |
|----------------------|----------------------|----------------------|
| Infrastructure       | Managed by you (EC2) | Fully managed by AWS |
| Scaling             | Manual/Auto Scaling   | Auto scales with demand |
| Pricing             | Pay for EC2 instances | Pay per vCPU and memory |
| Security & Isolation | Shared EC2 instances | Task-level isolation |
| Networking          | VPC, Security Groups  | Uses AWS VPC networking |

---

## **Task Definition in ECS**
A **Task Definition** is a blueprint for running containers in ECS. It defines:
- **Container Image** (ECR/Docker Hub)
- **CPU & Memory Allocation**
- **Networking (Bridge/AWS VPC)**
- **Logging (CloudWatch)**
- **Environment Variables**
- **IAM Roles & Permissions**

### **Task Definition Configuration for Fargate**
When creating a Fargate task, you must specify vCPU and memory.

| **vCPU**  | **Memory Range**         | **Increment** |
|-----------|--------------------------|--------------|
| **0.25**  | 0.5 GB, 1 GB, and 2 GB    | Fixed Options |
| **0.5**   | 1 GB - 4 GB               | 1 GB steps  |
| **1**     | 2 GB - 8 GB               | 1 GB steps  |
| **2**     | 4 GB - 16 GB              | 1 GB steps  |
| **4**     | 8 GB - 30 GB              | 4 GB steps  |
| **8**     | 16 GB - 60 GB             | 4 GB steps  |
| **16**    | 32 GB - 120 GB            | 8 GB steps  |

### **Configuring Task Definition in AWS Console**
1. Navigate to **ECS Console** → **Task Definitions** → **Create New Task Definition**
2. Select **Fargate** launch type
3. Enter **Task Name**
4. Under **Task size**, choose vCPU and Memory from the table above
5. Define **Container Configuration** (Image, Ports, etc.)
6. Configure **IAM Roles & Networking**
7. Save and deploy the task

### **Configuring Task Definition via AWS CLI**
```sh
aws ecs register-task-definition --family my-task \
  --cpu "1024" --memory "2048" \
  --requires-compatibilities "FARGATE"
```
- `--cpu "1024"` → **1 vCPU**
- `--memory "2048"` → **2 GB RAM**
- `--requires-compatibilities "FARGATE"` → Ensures it is a Fargate task

---

## **Advantages of Using Fargate**
1. **No Server Management** - No need to manage EC2 instances
2. **Cost Efficiency** - Pay for only CPU and memory used
3. **Security** - Provides task-level isolation
4. **Auto Scaling** - Easily scale tasks automatically
5. **Better Networking** - Runs within AWS VPC for better control
6. **Simplified Deployment** - No need to manage infrastructure

---

## **Deploying an ECS Service with Fargate**
### **Step 1: Create an ECS Cluster**
```sh
aws ecs create-cluster --cluster-name my-cluster
```

### **Step 2: Register Task Definition**
```sh
aws ecs register-task-definition --family my-task \
  --cpu "1024" --memory "2048" --network-mode "awsvpc" \
  --requires-compatibilities "FARGATE"
```

### **Step 3: Create an ECS Service**
```sh
aws ecs create-service --cluster my-cluster \
  --service-name my-service --task-definition my-task \
  --desired-count 2 --launch-type FARGATE
```

---

## **Conclusion**
- **ECS** provides container orchestration, and **Fargate** simplifies deployment by removing infrastructure management.
- **Task definitions** define how a container runs, including CPU, memory, and networking settings.
- **Fargate provides serverless execution** with better security, auto-scaling, and cost efficiency.
- Use **AWS Console or CLI** to configure ECS & Fargate efficiently.

# AWS ECS and Fargate - Complete Guide

## 🚀 Introduction
Amazon **Elastic Container Service (ECS)** is a fully managed container orchestration service that allows you to deploy, manage, and scale containerized applications. ECS supports two launch types:
- **EC2 launch type**: Runs containers on EC2 instances.
- **Fargate launch type**: Serverless option where AWS manages the infrastructure.

---
## 📌 ECS Roles
### **1️⃣ Task Role (IAM Role for ECS Task Execution)**
- The **Task Role** allows the **containerized application inside the ECS task** to access AWS resources (e.g., S3, DynamoDB, SSM Parameters, Secrets Manager, etc.).
- Defined in the **task definition**.

#### **Example Policy for S3 Access**
```json
{
    "Effect": "Allow",
    "Action": ["s3:GetObject"],
    "Resource": "arn:aws:s3:::my-bucket/*"
}
```

### **2️⃣ Execution Role (IAM Role for ECS Agent and AWS API Calls)**
- The **Execution Role** allows **ECS to pull container images from Amazon ECR** and fetch **secrets from AWS Secrets Manager**.
- Used during **task startup**.
- Must have policies like `AmazonECSTaskExecutionRolePolicy`.

#### **Example Policy**
```json
{
    "Effect": "Allow",
    "Action": ["ecr:GetDownloadUrlForLayer", "secretsmanager:GetSecretValue"],
    "Resource": "*"
}
```

---
## 📦 Port Mappings in ECS
ECS uses **port mappings** to expose services running inside containers. There are three networking modes:

### **1️⃣ Bridge Mode (Used in EC2 Launch Type)**
- The **container’s port is mapped to a different host port**.
- Example:
```json
"portMappings": [
  {
    "containerPort": 3000,
    "hostPort": 80,
    "protocol": "tcp"
  }
]
```
- **Access the application via:** `http://<HOST_IP>:80`

### **2️⃣ Host Mode (Used in EC2 Launch Type)**
- The **container port is directly mapped to the host port** (must be the same).
- Example:
```json
"portMappings": [
  {
    "containerPort": 80,
    "protocol": "tcp"
  }
]
```
- **Access via:** `http://<HOST_IP>:80`

### **3️⃣ AWSVPC Mode (Used in AWS Fargate)**
- The **container gets its own network interface**.
- No need to define the host port.
- Example:
```json
"portMappings": [
  {
    "containerPort": 80,
    "protocol": "tcp"
  }
]
```
- **Access via:** `http://<TASK_PUBLIC_IP>:80`

---
## 🌐 AWS VPC (Virtual Private Cloud)
**AWS VPC** provides a private and secure network for ECS tasks.

### **VPC Components**
| Component  | Description |
|------------|-------------|
| **Subnets** | Divides VPC into public/private networks |
| **Security Groups** | Firewall for controlling inbound/outbound traffic |
| **Internet Gateway** | Enables internet access for public subnets |
| **NAT Gateway** | Allows private subnet instances to access the internet |

---
## 🛠️ How to Load Your App in a Browser
- If using **Bridge Mode**: `http://<HOST_IP>:<HOST_PORT>`
- If using **Host Mode**: `http://<HOST_IP>:<CONTAINER_PORT>`
- If using **AWSVPC Mode** (Fargate): `http://<TASK_PUBLIC_IP>:<CONTAINER_PORT>`

---
## ✅ Conclusion
- **Use Bridge Mode** for EC2-based containers with mapped ports.
- **Use Host Mode** when direct port mapping is required.
- **Use AWSVPC Mode (Fargate)** for fully managed, isolated networking.
- Always **configure proper IAM roles** for security and permissions.


# AWS Systems Manager (SSM) - Session Manager

## Overview
AWS **Systems Manager (SSM)** is a powerful service that helps manage and automate operational tasks for AWS resources. One of its key features is **Session Manager**, which allows secure shell (CLI-based) access to EC2 instances and ECS containers without requiring SSH, bastion hosts, or opening inbound ports.

---

## Why Use AWS SSM Session Manager?
### **Benefits:**
- **No Need for SSH or Bastion Hosts** – Eliminates the need to expose port 22.
- **IAM-Based Access Control** – Uses IAM policies instead of traditional key-based authentication.
- **Audit and Logging** – Logs all session activity to AWS CloudTrail, Amazon S3, or CloudWatch for security and compliance.
- **Works in Private Networks** – Provides access to instances in private subnets without requiring a VPN or NAT Gateway.
- **Supports ECS Exec** – Enables secure interaction with running ECS containers.

---

## How Does SSM Session Manager Work?
### **Requirements:**
1. **SSM Agent Installed** – Ensure the **AWS SSM Agent** is installed and running on the EC2 instance or ECS task.
2. **IAM Role with SSM Permissions** – The instance or container must have an IAM role with the `ssm:StartSession` permission.
3. **Session Initiation Methods:**
   - AWS Console (Session Manager)
   - AWS CLI:
     ```bash
     aws ssm start-session --target <instance-id>
     ```
   - AWS SDK
4. **Logging & Monitoring** – Optionally, configure CloudWatch or S3 for session logging.

---

## Example: Start an SSM Session on an EC2 Instance
Run the following command to open an interactive session inside your EC2 instance:
```bash
aws ssm start-session --target i-0123456789abcdef0
```

---

## SSM Session Manager vs SSH
| Feature | SSM Session Manager | SSH |
|---------|---------------------|-----|
| Port 22 Needed? | ❌ No | ✅ Yes |
| IAM-Based Access | ✅ Yes | ❌ No |
| CloudTrail Logging | ✅ Yes | ❌ No |
| Works in Private Subnet | ✅ Yes | ❌ No |
| Requires Key Pair | ❌ No | ✅ Yes |

---

## Conclusion
AWS **SSM Session Manager** enhances security, simplifies access management, and eliminates the need for traditional SSH-based access. It is a recommended best practice for managing AWS EC2 instances and ECS containers securely.


