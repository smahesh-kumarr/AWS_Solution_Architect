#Create a S3 for the data source

aws s3 mb s3://kendra-exp-1234 --region us-east-1
aws s3 cp Oliver-twist.pdf s3://kendra-exp-1234 --region us-east-1

## Creating a Kendra Index

```sh
aws kendra create-index \
--edition DEVELOPER_EDITION \
--description "My Index" \
--region us-east-1 \
--role-arn arn:aws::983453213453"role/KendraIndexRole
```

## Creating our data Stream
aws kendra create-data-source \
--index-id 62f0df1-b38b-44a6-8152-ff7427fdff08
--name my-data-source \ 
--role-arn arn:aws:iam:983453213453:role/kendraDataSourceRole \
--type s3 \
--configuration '{"S3Configuration":{"BucketName:" "kendra-exp-1234"}}'
--region us-east-1

## Sync 
```sh
aws kendra start-data-source-sync-job \
--id e3ceb99f-8547-4ff7-95c7-2e113c2ffc75 \
--index-id 62f0df1-b38b-44a6-8152-ff7427fdff08
--region us-east-1
```

# Query 

```sh
aws kendra query 
--index-id 62f0df1-b38b-44a6-8152-ff7427fdff08
--query-text "What characters are in the book Oliver Twist?"
```
