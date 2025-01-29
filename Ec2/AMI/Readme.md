# EC2 AMI and Snapshots

## What is an Amazon Machine Image (AMI)?
An **Amazon Machine Image (AMI)** is a pre-configured template that contains the information required to launch an EC2 instance. It serves as a blueprint for your virtual servers.

### 📌 Key Features of AMI:
- **Operating System & Software**: Includes an OS (Linux, Windows) and pre-installed applications.
- **Launch Permissions**: Controls which AWS accounts can use the AMI.
- **Storage Configuration**: Specifies the root volume and additional storage devices.

## How Does an AMI Work?
1. **Create an EBS Snapshot** (or an instance store template).
2. **Register the Snapshot** as an AMI.
3. **Launch EC2 Instances** using the AMI.
4. **Copy the AMI** across AWS Regions if needed.
5. **Deregister the AMI** if it is no longer required.

🟢 **AMIs are Region-Specific!** If you need an AMI in another AWS region, you must copy it.

## What is an EBS Snapshot?
A **snapshot** is a backup of an Amazon Elastic Block Store (EBS) volume. Snapshots are stored in Amazon S3 and can be used to create AMIs or restore data in case of failure.

### 📌 Key Features of Snapshots:
- **Incremental Backups**: Only stores changes made since the last snapshot, saving storage space.
- **Cross-Region Copying**: Can be replicated to different AWS regions for disaster recovery.
- **Restoration**: Snapshots can be used to create new EBS volumes or AMIs.

## Example Workflow
Imagine you have an EC2 instance running a web application. You want to back up the instance and create a reusable template.

### Step 1: Create an EBS Snapshot
```sh
aws ec2 create-snapshot --volume-id vol-0abcd1234 --description "My Web Server Backup"
```

### Step 2: Register an AMI
```sh
aws ec2 register-image \
    --name "WebServer-AMI" \
    --root-device-name /dev/xvda \
    --block-device-mappings '[{"DeviceName":"/dev/xvda","Ebs":{"SnapshotId":"snap-0123456789abcdef0"}}]'
```

### Step 3: Launch an Instance from AMI
```sh
aws ec2 run-instances --image-id ami-0abcd1234ef56789 --instance-type t2.micro --count 1
```

## Why Use AMIs and Snapshots?
✅ **Easy Scaling** – Quickly launch multiple instances from a single AMI.
✅ **Backup & Recovery** – Snapshots provide disaster recovery options.
✅ **Cross-Region Availability** – Copy AMIs and snapshots to different AWS regions.
✅ **Cost Optimization** – Reduce storage costs by using incremental snapshots.

---
🚀 **By leveraging AMIs and snapshots, you can efficiently manage EC2 instances, automate deployments, and ensure high availability for your applications.**
