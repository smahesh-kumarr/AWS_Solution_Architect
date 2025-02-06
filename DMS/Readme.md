### Step 1: Create Databases Using CloudFormation (YAML)

-  Create a CloudFormation YAML template to provision PostgreSQL (source) and MySQL (target) databases in Amazon RDS.

```sh
aws cloudformation create-stack --stack-name DMSStack \
--template-body file://template.yml
```
# Database Migration with AWS DMS

## Step 3: Login to the Databases via TablePlus
Once the PostgreSQL and MySQL databases are created, connect using TablePlus:

### PostgreSQL Connection
- **Host**: `<RDS PostgreSQL Endpoint>`
- **Port**: 5432
- **Username**: admin
- **Password**: MySecurePassword123
- **Database**: postgres

### MySQL Connection
- **Host**: `<RDS MySQL Endpoint>`
- **Port**: 3306
- **Username**: admin
- **Password**: MySecurePassword123
- **Database**: mysql

## Step 4: Create Sample Database Schema in PostgreSQL
Run the following SQL query in PostgreSQL Workbench:

```sql
CREATE DATABASE student_records;

\c student_records;

CREATE TABLE StudentInfo (
    ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Dept VARCHAR(50),
    CGPA DECIMAL(3,2),
    PassedYear INT,
    Age INT
);

INSERT INTO StudentInfo (Name, Dept, CGPA, PassedYear, Age) 
VALUES 
    ('Alice', 'CSE', 8.9, 2022, 23),
    ('Bob', 'ECE', 7.5, 2021, 24),
    ('Charlie', 'MECH', 8.0, 2023, 22);


# Step 1: Verify Data Exists in PostgreSQL
# Log into PostgreSQL and check the data in your table
psql -h <PostgreSQL Endpoint> -U admin -d student_records
SELECT * FROM StudentInfo;

# Step 2: Login into MySQL and Test Connection
# Log into MySQL and check the available databases
mysql -h <MySQL Endpoint> -u admin -p
SHOW DATABASES;

# Step 3: Create a Replication Instance in AWS DMS
# Create the replication instance via AWS CLI
aws dms create-replication-instance \
    --replication-instance-identifier my-replication-instance \
    --replication-instance-class dms.t3.medium \
    --allocated-storage 50 \
    --vpc-security-group-ids sg-xxxxxx

# Wait for the replication instance to be available
# Monitor replication instance creation through AWS DMS Console or CLI

# Step 4: Enable S3 Report in AWS DMS
# Enable S3 logging for AWS DMS
# Navigate to AWS DMS Console → Migration Hub → Replication Instances
# Enable S3 Report and choose a bucket to store logs

# Step 5: Create Source Endpoint (PostgreSQL)
aws dms create-endpoint \
    --endpoint-identifier source-endpoint \
    --endpoint-type source \
    --engine-name postgres \
    --username admin \
    --password MySecurePassword123 \
    --server-name <RDS PostgreSQL Endpoint> \
    --port 5432 \
    --database-name student_records

# Step 6: Create Target Endpoint (MySQL)
aws dms create-endpoint \
    --endpoint-identifier target-endpoint \
    --endpoint-type target \
    --engine-name mysql \
    --username admin \
    --password MySecurePassword123 \
    --server-name <RDS MySQL Endpoint> \
    --port 3306 \
    --database-name student_records

# Step 7: Create Migration Task
aws dms create-replication-task \
    --replication-task-identifier migrate-students \
    --source-endpoint-arn <source-endpoint-arn> \
    --target-endpoint-arn <target-endpoint-arn> \
    --migration-type full-load \
    --table-mappings file://table-mappings.json \
    --replication-instance-arn <replication-instance-arn>

# Step 8: Enable CloudWatch Alarms for Migration Failures
# Go to AWS CloudWatch → Alarms → Create Alarm
# Select DMS Replication Task Metrics
# Configure to alert on migration failures (optional)

# Step 9: Test Endpoints
# Test the source endpoint connection
aws dms test-connection \
    --endpoint-arn <source-endpoint-arn>

# Test the target endpoint connection
aws dms test-connection \
    --endpoint-arn <target-endpoint-arn>

# Ensure both tests succeed before proceeding

# Step 10: Auto Schema Creation & Start Migration
# Start the migration task
aws dms start-replication-task \
    --replication-task-arn <replication-task-arn> \
    --start-replication-task-type start-replication

# This will auto-create the schema in MySQL and load the data

# Step 11: Verify Data in MySQL
# After migration is completed, verify the data in MySQL
mysql -h <MySQL Endpoint> -u admin -p
SELECT * FROM StudentInfo;
