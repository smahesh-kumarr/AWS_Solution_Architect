## Create a s3 Bucket

aws s3 ab s3://metadata-bucket-443243 --region us-east-1

### Create a new file

echo "Hello Mars" > hello.txt

## Upload file with metadata

aws s3 put-object --bucket="metadata-bucket-443243" --key hello.txt --body hello.txt --metadata Planet=Mars 

