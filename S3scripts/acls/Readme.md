## Create a Account

```sh
aws s3api create-bucket --bucket my-bucket-23456789 --region us-east-1
```

## Turn on block Public Access

aws s3api put-public-access-block \
    <!-- --account-id 123456789012 \ -->
    --bucket my-bucket-23456789 \
    --public-access-block-configuration "BlockPublicAcls": false, "IgnorePublicAcls": false, "BlockPublicPolicy": true, "RestrictPublicBuckets": true


## To getr access Details
aws s3api get-public-access-block --bucket my-bucket-23456789

```sh
aws s3api put-bucket-ownership=controls \
--bucket my-bucket-23456789 \
--ownership-controls="Rules=[{ObjectOwnership=BucketOwnerEnforced}]"

```

```sh
aws s3api put-bucket-acl \
--bucket my-bucket-23456789 \
--access-control-policy file:///workspace/AWS_Solution_Architect/S3scripts/acls/policy.json
```

```sh
touch bootcamp.txt
aws s3 cp bootcamp.txt s3://--bucket my-bucket-23456789 
aws s3 ls s3://--bucket my-bucket-23456789 

aws s3 rm s3://--bucket my-bucket-23456789/bootcamp.txt
aws s3 rb s3://--bucket my-bucket-23456789

