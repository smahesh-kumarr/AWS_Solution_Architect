
## Meta Data Version-1

### Meta Data Accessing Url

```sh
curl http://169.254.169.254/latest/meta-data/
```
### Meta Data Acccesing Url-2
```sh
wget -qo http://169.254.169.254/latest/meta-data/public-ipv4
```


## Meta data version-2 

```sh
aws ec2 modify-instance-metadata-options \
--instance-id i-1234567898abcdef0 \
--http-tokens required \
--http-endpoint enabled \
--region ca-central-1
```

### Metadata access the V2 Token Generation 


```sh
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"
```