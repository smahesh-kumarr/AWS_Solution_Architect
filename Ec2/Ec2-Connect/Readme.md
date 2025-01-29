
export AWS_ACCESS_KEY_ID ="My-Access-Id"
export AWS_SECRET_ACCESS_KEY ="Secret-Access"
export AWS_DEFAULT_REGION ="ca-central-1"

gp env AWS_ACCESS_KEY_ID ="My-Access-Id"
gp env AWS_SECRET_ACCESS_KEY ="Secret-Accesss"
gp env AWS_DEFAULT_REGION ="ca-central-1"

```sh
ssh-keygen -t rsa -f ec2connect
```


```sh
aws ec2-instance-connect send-ssh-public-key \
--instance-id i-1234567890abcdef0 \
--instance-os-user ec2-user \
--availability-zone us-east-2b \
--ssh-public-key file://path/ec2.pub
```

```sh
ssh -i ec2connect ec2-user@3.99.178.17
```