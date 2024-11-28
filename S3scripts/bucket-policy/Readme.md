## Create a Bucket

aws s3 mb s3://bucket-policy-234532334 --region us-east-1


## Create a Bucket polixy

aws s3api put-bucket-policy --bucket bucket-policy-234532334 --policy file://policy.json

##In other account 
aws s3 ls s3://bucket-policy-234532334
touch bootcamp.txt
aws s3 cp bootcamp.txt s3://bucket-policy-234532334
aws s3 ls s3://bucket-policy-234532334

## clean up 

aws s3 rm s3://bucket-policy-234532334/bootcamp.txt
aws s3 rb s3://bucket-policy-234532334