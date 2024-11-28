## Create a bucket 
 aws s3 mb s3://fun-ab-2345678 --region us-east-1

 ## Change the public access

```sh
 aws s3api put-public-access-block \
    --bucket fun-ab-2345678 \
    --public-access-block-configuration IgnorePublicAcls=true,BlockPublicPolicy=false,BlockPublicAcls=true,RestrictPublicBuckets=false
```

## Create a Bucket policy 

aws s3api put-bucket-policy --bucket fun-ab-2345678 --policy file://bucket-policy.json


## Create a website policy
```sh
aws s3api put-bucket-website --bucket fun-ab-2345678 --website-configuration file://website.json
```

## Upload to s3 
aws s3 cp index.html s3://fun-ab-2345678


## View index.html file 
https://fun-ab-2345678.s3-website-us-east-1.amazonaws.com

## Create a website2

## Create a bucket 
 aws s3 mb s3://fun-ab-2345679 --region us-east-1

 ## Change the public access

```sh
 aws s3api put-public-access-block \
    --bucket fun-ab-2345679 \
    --public-access-block-configuration IgnorePublicAcls=true,BlockPublicPolicy=false,BlockPublicAcls=true,RestrictPublicBuckets=false
```

## Create a Bucket policy 

aws s3api put-bucket-policy --bucket fun-ab-2345679 --policy file://bucket-policy.json


## Create a website policy
```sh
aws s3api put-bucket-website --bucket fun-ab-2345679 --website-configuration file://website.json
```

## Upload to s3 
aws s3 cp index.html s3://fun-ab-2345679

