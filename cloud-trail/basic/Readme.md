# Create a bucket for cloud Trial logs

aws s3 mb s3://my-cloud-trail-logs-987643

# Create a trail

aws s3api put-bucket-policy --bucket my-cloud-trail-logs-987643 --policy file://bucket-policy.json

# Create a Trail 

aws cloudtrail create-trail \
--name MyTrail \
--s3-bucket-name my-cloud-trail-logs-987643 \
--region ca-central-1


# AWS Start Logging

aws cloudtrail start-logging --name MyTrail


