# Auto Scaling Group (ASG) with Application Load Balancer (ALB) in AWS

This repository provides an Infrastructure as Code (IaC) setup for configuring an **Auto Scaling Group (ASG)** with an **Application Load Balancer (ALB)** in AWS. The setup ensures high availability, scalability, and fault tolerance.

## 📌 Overview
This deployment includes:
- **VPC Configuration**: A Virtual Private Cloud (VPC) with public subnets.
- **Internet Gateway**: Enables internet access for public resources.
- **Subnets**: Defined CIDR ranges for public networking.
- **Route Table**: Controls routing within the VPC.
- **Target Group**: Points to EC2 instances for load balancing.
- **Application Load Balancer (ALB)**: Distributes traffic across instances.
- **Security Groups**: Restricts access to only necessary ports.
- **Launch Template**: Defines instance configurations for ASG.
- **Auto Scaling Group (ASG)**: Dynamically manages instance count.

---

## 🚀 Deployment Steps

### 1️⃣ VPC Configuration
1. **Create a VPC**  
   - Define a CIDR block (e.g., `10.0.0.0/16`).
2. **Create and Attach an Internet Gateway**  
   - Attach it to the VPC for internet access.
3. **Create Public Subnets**  
   - Assign a CIDR range (e.g., `10.0.1.0/24`).
4. **Configure Route Table**  
   - Associate the subnets and define internet access rules.

### 2️⃣ Target Group Configuration
1. **Create a Target Group**  
   - Define a target type (e.g., EC2 instances).  
   - Choose the protocol (HTTP/HTTPS).  
   - Configure health check settings.

### 3️⃣ Load Balancer Configuration
1. **Create an Application Load Balancer (ALB)**  
   - Attach public subnets.  
   - Assign a security group allowing HTTP (`port 80`).  
   - Register instances with the target group.

### 4️⃣ Launch Template Configuration
1. **Define an AMI & Instance Type**  
   - Specify the Amazon Machine Image (AMI) and instance type.  
   - Configure key pair, IAM roles, and user data scripts.

### 5️⃣ Auto Scaling Group (ASG) Setup
1. **Create an Auto Scaling Group**  
   - Link it to the launch template.  
   - Set desired capacity and scaling policies.

---

## 🏗️ Prerequisites
- AWS CLI installed and configured.
- IAM user with `AdministratorAccess` or specific permissions.
- Terraform or AWS CloudFormation (if deploying via IaC).
- Basic knowledge of AWS networking.

