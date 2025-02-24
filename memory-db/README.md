# AWS VPCs, Subnets, and MemoryDB for Redis

## VPCs and Subnets in AWS

### Number of VPCs per Availability Zone (AZ):
- A **VPC is a regional resource**, meaning it spans across multiple Availability Zones (AZs) within a region.
- You can create **up to 5 VPCs per AWS region** by default (soft limit). This limit can be increased by requesting AWS support.
- Since a VPC spans the entire region, there is **no fixed limit on the number of VPCs per AZ**, but there is a **limit on the total number of VPCs per region**.

### Number of Subnets in a Single AZ:
- A **subnet is an AZ-specific resource**, meaning it resides in a single Availability Zone.
- You can create **up to 200 subnets per VPC** (soft limit, can be increased).
- All 200 subnets can be created in a **single AZ**, or distributed across multiple AZs in the region.

---

## AWS MemoryDB for Redis

### What is MemoryDB for Redis?
AWS **MemoryDB for Redis** is a **fully managed, in-memory database** that is compatible with Redis. It is used for **high-performance caching and real-time applications**.

### What is the Cluster in MemoryDB?
- The **cluster** in MemoryDB is the **database infrastructure** itself.
- It consists of **nodes (instances)** that store and replicate data.
- A cluster can have multiple **shards**, where each shard has **a primary node (for writes) and replicas (for reads).**
- The cluster is **not a machine you directly interact with**, but rather a managed service that runs the database.

---

## Why is an EC2 Instance Used?
Even though MemoryDB is a **fully managed** database, it does not provide a built-in UI or direct access for running commands. You need a **client machine** to connect to the MemoryDB cluster and interact with it.

### **Use of EC2 Instance in This Setup**
The EC2 instance is used to:
- ✅ **Install Redis CLI (Command-Line Interface)** via user data.
- ✅ **Connect to the MemoryDB cluster** and execute Redis commands (`SET`, `GET`, etc.).
- ✅ **Test the database** before integrating it with an application.
- ✅ **Serve as an application server** that interacts with MemoryDB (optional).

### **Why Not Connect Directly to the Cluster?**
- MemoryDB is **not like RDS** where you can connect via SQL clients.
- You need a **Redis client** (like `redis-cli` or `hiredis`) to interact with the cluster.
- The EC2 instance acts as a **jump server** or **application server** to access the Redis database.

---

## **Summary**

| Component            | Purpose                                       |
|----------------------|-----------------------------------------------|
| **MemoryDB Cluster** | The database that stores and processes in-memory data. |
| **Subnet Group**     | Defines where the MemoryDB nodes will be placed. |
| **User & ACL**       | Controls access to MemoryDB. |
| **EC2 Instance**     | Acts as a client machine to connect and run Redis commands. |

---

### **Connecting to MemoryDB from EC2**
Once configured, SSH into your EC2 instance and test the connection:
```bash
redis-cli -h your-cluster-name.memorydb.region.amazonaws.com -p 6379
```
If ACLs are enabled:
```bash
redis-cli -h your-cluster-name.memorydb.region.amazonaws.com -p 6379 -a "your-redis-password"
```
For TLS:
```bash
redis-cli -h your-cluster-name.memorydb.region.amazonaws.com -p 6379 --tls


# AWS MemoryDB for Redis Integration Guide

## 1. Architecture Overview
Your **application** (hosted on an EC2 instance, container, or AWS Lambda) will connect to the **MemoryDB cluster** to cache data or perform real-time operations.

### **Key Components in Your Configuration**
1. **MemoryDB Cluster Endpoint**
   - Use the **Primary Endpoint** for writes or **Reader Endpoint** for read-heavy workloads.
2. **Security Group & VPC Configuration**
   - The **EC2 instance (or container)** running your app must be in the **same VPC** or a **peered VPC**.
   - The **MemoryDB Security Group** should allow inbound traffic from your app’s security group on **port 6379** (default Redis port).
3. **Authentication & Access Control**
   - If **ACLs (Access Control Lists)** are enabled, your app must **authenticate with a MemoryDB user**.
   - If **TLS is enabled**, your app must use **TLS certificates** to connect securely.

---

## 2. Application Configuration

### **Example: Connecting from a Python Application**
Install the Redis client:
```bash
pip install redis
```
Configure your app to connect:
```python
import redis

# MemoryDB cluster primary endpoint
MEMORYDB_ENDPOINT = "your-cluster-name.memorydb.region.amazonaws.com"

# Connect to MemoryDB
redis_client = redis.StrictRedis(
    host=MEMORYDB_ENDPOINT,
    port=6379,  # Default Redis port
    password="your-redis-password",  # Use if ACLs are enabled
    ssl=True  # Enable if TLS is required
)

# Example operation
redis_client.set("key", "value")
print(redis_client.get("key"))
```

### **Example: Connecting from a Node.js Application**
Install the Redis client:
```bash
npm install redis
```
Configure your app:
```javascript
const redis = require("redis");

// MemoryDB cluster endpoint
const client = redis.createClient({
  url: "redis://your-cluster-name.memorydb.region.amazonaws.com:6379",
  password: "your-redis-password", // If ACL is enabled
  tls: {} // Required if TLS is enabled
});

client.connect()
  .then(() => console.log("Connected to MemoryDB"))
  .catch(err => console.error("Redis connection error:", err));

client.set("key", "value");
client.get("key").then(console.log);
```

---

## 3. Configuration Settings to Add
### **Application Configurations**
- **MemoryDB endpoint:** Store in **environment variables** or a **config file**.
- **Security:** Use **AWS Secrets Manager** to store credentials securely.
- **High Availability:** Use the **Reader Endpoint** for read-heavy applications.

### **VPC & Security Groups**
- Ensure the **EC2 instance's security group** allows outbound traffic to **MemoryDB's security group** on port `6379`.
- If using **Lambda**, ensure it has **VPC access** to the subnet containing MemoryDB.

---

## 4. Testing the Connection
Once configured, SSH into your EC2 instance and test the connection:
```bash
redis-cli -h your-cluster-name.memorydb.region.amazonaws.com -p 6379
```
If ACLs are enabled:
```bash
redis-cli -h your-cluster-name.memorydb.region.amazonaws.com -p 6379 -a "your-redis-password"
```
For TLS:
```bash
redis-cli -h your-cluster-name.memorydb.region.amazonaws.com -p 6379 --tls
```

---

## 5. Summary

| Component            | Configuration Needed                              |
|----------------------|--------------------------------------------------|
| **MemoryDB Cluster** | Get **Primary/Reader Endpoint**                  |
| **Security Groups**  | Allow **port 6379** between EC2 and MemoryDB     |
| **Authentication**   | Use **password** (if ACLs enabled)               |
| **TLS**             | Enable **SSL/TLS** if required                    |
| **Application Config** | Store **Redis endpoint, password, and security settings** |

Would you like help configuring this for a specific programming language? 🚀
