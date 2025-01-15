## TO get vpc id 

```sh
VPC_ID=$(aws ec2 describe-vpcs \
--filters "Name=tag:Name,Values=nacl-example-vpc" \ --query "Vpcs[0].VpcId" \
--output text)   
```

# NACL
```sh
aws ec2 create-network-acl --vpc-id vpc-044d2a6f03d126f53
```


## To Grab a instance Id which Amazon Linux free teir

```sh
aws ec2 describe-images \
--owners amazon \ 
--filters "Name=name,Values=amzn2-ami-kernel-*-x86_64-gp2" "Name=architecture,Values=x86_64" "Name=root-device-type,Values=ebs" "Name=is-public,Values=true" \
--query "Images | sort_by(@, &CreationDate)[-1].ImageId" \
--output text
```

## To Block a inbound traffic 

```sh
aws ec2 create-network-acl-entry \
--network-acl-id acl-081858949a4be7feb \  # Replace with your NACL ID
--rule-number 100 \                        # Rule number must be unique
--protocol -1 \                            # Protocol -1 means all protocols
--rule-action deny \                       # Deny the traffic
--cidr-block 152.58.199.103/32 \           # Block this specific IP address
--ingress 
```

