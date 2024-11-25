## Create a S3 Bucket
```
aws s3 mb s3://storage-class-5678 --region us-east-1
```

### Create a object 

touch  "Hello Bro" > hello.txt 

### Create a object

aws s3 cp hello.txt s3://storage-class-5678 --storage-class STANDARD_IA

### Clean up

aws s3 rm hello.txt s3://storage-class-5678/hello.txt

aws s3 rb hello.txt s3://storage-class-5678
