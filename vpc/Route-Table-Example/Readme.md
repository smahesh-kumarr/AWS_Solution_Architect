# Netflix Application VPC Architecture on AWS

This guide provides steps to set up a VPC structure on AWS for running a Netflix-like application. The architecture consists of a **Public Subnet** for the frontend, a **Private Subnet** for the backend, and a **NAT Gateway** for providing internet access to the private subnet. Additionally, a **VPC Peering Connection** is used to enable secure communication between the subnets.

## VPC Architecture Overview

### Components:
1. **Public Subnet**: Used for frontend instances (e.g., web servers or application servers), which need direct internet access to serve the application.
2. **Private Subnet**: Used for backend instances, which are not directly exposed to the internet but need internet access via a NAT Gateway (e.g., database instances, backend services).
3. **VPC Peering**: Connects the private subnet to the public subnet, ensuring secure and seamless communication between them.
4. **NAT Gateway**: Provides outbound internet access for instances in the private subnet, allowing them to access the internet for updates, external services, or data fetching, while keeping them hidden from direct external access.

## Steps to Set Up the VPC Structure and Route Table Configuration

### 1. Create the VPC
- CIDR block: `10.0.0.0/16`
- This allows for a large number of subnets and IP addresses within the VPC.

### 2. Create Public Subnet (for the frontend)
- CIDR block: `10.0.1.0/24`
- This subnet will host your frontend web servers or application servers.
- Associate with an **Internet Gateway (IGW)** for internet access.

### 3. Create Private Subnet (for the backend)
- CIDR block: `10.0.2.0/24`
- This subnet will host your backend services, like the database or thumbnail generation service.
- Does **not** have direct internet access but can use a **NAT Gateway** for outbound internet access.

### 4. Create a NAT Gateway
- Launch a **NAT Gateway** in the public subnet (`10.0.1.0/24`), so instances in the private subnet can access the internet.
- Ensure that you associate an Elastic IP with the NAT Gateway for outbound internet access.

### 5. Create VPC Peering
- If you're using two VPCs, create a **VPC Peering Connection** between the two VPCs (assuming frontend and backend are in separate VPCs), and update the route tables to allow communication between them.

## Route Tables Configuration

### 1. Route Table for Public Subnet (Frontend)
- Public subnet's route table allows outbound internet access via the **Internet Gateway** for the frontend instances.
  
**Route Table Example:**
```plaintext
Destination       | Target
------------------|-----------------------------------------
10.0.0.0/16       | Local (default route for VPC)
0.0.0.0/0         | Internet Gateway (IGW)
```

### 2. Route Table for Private Subnet (Backend)

*   Private subnet’s route table will route traffic through the **NAT Gateway** for outbound internet access.
*   If you are using **VPC Peering**, you'll add routes to the public subnet's CIDR block to enable communication.

**Route Table Example:**
```plaintext
Destination       | Target
------------------|-----------------------------------------
10.0.0.0/16       | Local (default route for VPC)
0.0.0.0/0         | NAT Gateway (to access the internet)
10.0.1.0/24       | VPC Peering Connection (if frontend in separate VPC)
```

# Route Table Configuration for VPC Peering (If Applicable)

*   If your frontend and backend are hosted in separate VPCs, you need to configure route tables in both VPCs to enable communication between the public and private subnets.

### Route Table for Public Subnet (Frontend VPC)

### Add the following route to allow traffic from the frontend (public subnet) to reach the backend (private subnet) through the VPC Peering connection:

```plaintext
Destination       | Target
------------------|-----------------------------------------
10.0.2.0/24       | VPC Peering Connection (to backend VPC)
```
*   Route Table for Private Subnet (Backend VPC)
*   Add the following route to allow traffic from the backend (private subnet) to reach the frontend (public subnet) through the VPC Peering connection:


```plaintext
Destination       | Target
------------------|-----------------------------------------
10.0.1.0/24       | VPC Peering Connection (to frontend VPC)
```

*   This configuration ensures secure communication between the frontend and backend subnets across different VPCs using VPC Peering.
