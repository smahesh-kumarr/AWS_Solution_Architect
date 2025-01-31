# **AWS Elastic Load Balancer (ELB) - Complete Guide**

## **Overview**
AWS **Elastic Load Balancer (ELB)** is a highly scalable and fully managed service that distributes incoming traffic across multiple targets (EC2 instances, containers, IPs) to ensure high availability, fault tolerance, and reliability of applications.

---

## **Types of AWS Load Balancers**
AWS provides three main types of load balancers under ELB:

### **1️⃣ Application Load Balancer (ALB)**
🔹 **Layer:** 7 (Application Layer - HTTP/HTTPS)  
🔹 **Best For:** Web applications, APIs, microservices  
🔹 **Features:** Path-based & host-based routing, WebSocket support, HTTP/2, Integration with ECS/Kubernetes  

**📌 Example:**
- A website (`www.example.com`) has two services:
  - `/shop` → Routed to **Shop Service Instances**
  - `/blog` → Routed to **Blog Service Instances**
- ALB intelligently directs users to the correct backend based on the URL path.

**🔹 Use ALB when you need:**
- Routing based on **URL path, hostname, or headers**
- Load balancing for **microservices**
- Support for **HTTPS termination**

---

### **2️⃣ Network Load Balancer (NLB)**
🔹 **Layer:** 4 (Transport Layer - TCP/UDP/TLS)  
🔹 **Best For:** High-performance applications, real-time processing  
🔹 **Features:** Millions of requests per second, static IP support, low latency  

**📌 Example:**
- A **real-time stock trading application** requires ultra-low latency.
- Users send stock orders over **TCP connections**.
- NLB efficiently distributes this traffic across multiple EC2 instances.

**🔹 Use NLB when you need:**
- **Ultra-fast processing** with millions of requests per second
- **TCP/UDP** traffic balancing
- **Static IPs** for fixed routing

---

### **3️⃣ Gateway Load Balancer (GWLB)**
🔹 **Layer:** 3 (Network Layer)  
🔹 **Best For:** Security appliances (firewalls, intrusion detection)  
🔹 **Features:** Routes traffic through third-party security appliances  

**📌 Example:**
- All incoming traffic must be **scanned by a firewall** before reaching EC2 instances.
- **GWLB** ensures every request is inspected by security appliances before passing to backend servers.

**🔹 Use GWLB when you need:**
- **Security filtering** (firewalls, IPS/IDS)
- **Traffic inspection before reaching applications**
- **Seamless integration** with third-party security vendors

---

## **Comparison Table**
| Load Balancer Type  | Layer | Best For | Example Use Case |
|-------------------|------|----------|-----------------|
| **Application Load Balancer (ALB)** | Layer 7 | Web apps, APIs, microservices | Routing `/shop` vs `/blog` traffic |
| **Network Load Balancer (NLB)** | Layer 4 | High-performance, low latency apps | Stock trading app with TCP connections |
| **Gateway Load Balancer (GWLB)** | Layer 3 | Security appliance traffic routing | Sending traffic through a firewall before reaching backend |

---

## **How to Set Up an ELB in AWS**
### **Step 1: Create a Load Balancer**
1. Go to the **AWS Management Console** → **EC2** → **Load Balancers**.
2. Click on **Create Load Balancer**.
3. Select **ALB, NLB, or GWLB** based on your requirements.

### **Step 2: Configure the Load Balancer**
1. Set a **Name** for your load balancer.
2. Choose the appropriate **VPC and Availability Zones**.
3. Configure **Security Groups** and **Listeners** (for ALB, choose HTTP/HTTPS).

### **Step 3: Define Target Groups**
1. Create a **Target Group** and choose **Instances, IPs, or Lambda**.
2. Register EC2 instances or other backends.

### **Step 4: Test the Load Balancer**
1. Copy the **DNS name** of your load balancer.
2. Open a browser and test the connection.
3. Use `curl` or `ping` to verify load balancing.

---
