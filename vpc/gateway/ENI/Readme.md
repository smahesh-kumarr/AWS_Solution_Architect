# Elastic Network Interface (ENI) in Amazon EC2

## Overview

An **Elastic Network Interface (ENI)** is a virtual network card that enables Amazon EC2 instances to connect to a network. ENIs are flexible and allow instances to communicate within and across subnets, Virtual Private Clouds (VPCs), and even the internet.

This repository explains what ENIs are, their benefits, and includes examples to demonstrate their usage.

---

## Key Features of ENI

- **Multiple IP Addresses:** Assign multiple private or Elastic IPs to an ENI.
- **Network Redundancy:** Enable failover by dynamically detaching and attaching ENIs.
- **Traffic Separation:** Separate public and private traffic using multiple ENIs.
- **Enhanced Security:** Apply different security groups and control traffic flow.
- **Dynamic Management:** Move ENIs between EC2 instances for maintenance or scaling.
- **Scalability:** Use ENIs to handle traffic surges by adding additional IPs or instances.

---

## Why Use ENI?

ENIs are widely used because they provide:
1. **High Availability:** Easily migrate network configurations between instances.
2. **Traffic Isolation:** Segregate traffic for security and performance (e.g., public vs. private).
3. **Scalability:** Attach additional ENIs to manage increasing workloads.
4. **Flexibility:** Dynamic reallocation of network resources during instance replacements or scaling.

---

## Example Use Case: Web and Database Segregation

Imagine a web server needs to handle:
1. **Public traffic** for user requests (HTTP/HTTPS).
2. **Private traffic** for communication with a database.

### Configuration:
- **ENI 1 (Public):** Connected to a public subnet with an Elastic IP for internet-facing traffic.
- **ENI 2 (Private):** Connected to a private subnet for secure communication with the database.

This setup ensures:
- Secure isolation between public and private traffic.
- Easy migration of ENIs in case of instance failure.