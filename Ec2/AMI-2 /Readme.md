## Create a Image with the Ec2 id 

```sh 
aws ec2 create-image instance-id i-eace245ddca5d8aa3 --name "My-image"
```


## Copy a image to another region

```sh
aws ec2 copy-image --source-region us-east-1 --source-image-id ami-06bb02361dd3b844 --name "My copied AMI" --region ca-central-1 --encrypted
```

 