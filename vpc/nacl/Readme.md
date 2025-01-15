## TO get vpc id 

```sh
VPC_ID=$(aws ec2 describe-vpcs \
--filters "Name=tag:Name,Values=nacl-example" \ --query "Vpcs[0].VpcId" \
--output text)   
```

# NACL
```sh
aws ec2 create-network-acl --vpc-id  
```


## To Grab a instance Id which Amazon Linux free teir

```sh
aws ec2 describe-images \
--owners amazon \ 
--filters "Name=name,Values=amzn2-ami-kernel-*-x86_64-gp2" "Name=architecture,Values=x86_64" "Name=root-device-type,Values=ebs" "Name=is-public,Values=true" \
--query "Images | sort_by(@, &CreationDate)[-1].ImageId" \
--output text
```


