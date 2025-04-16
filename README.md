# AWS_Solution_Architect
AWS Solution Architect Examples

# 📊 AWS CloudWatch Alarms

This project explains the concept and components of **AWS CloudWatch Alarms**, which help monitor AWS resources and trigger automated actions based on predefined metrics and thresholds.

---

## 🔔 What is a CloudWatch Alarm?

An **AWS CloudWatch Alarm** watches a **CloudWatch Metric** and performs one or more **actions** based on defined **thresholds**. Alarms help automate responses and send notifications when resource usage goes beyond expected limits.

---

## ✅ CloudWatch Alarm Key Components

### 1. **Metric**
- A measurable value for an AWS service (e.g., `CPUUtilization`, `NetworkIn`).
- Example: `NetworkIn` measures incoming traffic to an EC2 instance.

### 2. **Threshold**
- The condition that must be met to change the alarm state.
- Example:  
