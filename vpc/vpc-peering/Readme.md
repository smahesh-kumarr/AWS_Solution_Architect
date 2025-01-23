## Create Vpc Peer Connection

### 1.Create vpc with 2 vpc and more with all default components 

### Peer a Two Vpc
```sh
aws ec2 create-vpc-peering-connection --vpc-id vpc-0959c66103f9d0c24 --peer-vpc-id vpc-025060c53c8e3b90f
```

### Accept the Peer Connection
```sh
aws ec2 accept-vpc-peering-connection --vpc-peering-connection-id pcx-046f6b328e684fd90
```

### Create a Route for vpc-a to vpc-b
```sh
aws ec2 create-route --route-table rtb-0443b1712612dc073 --destination-cidr-block 12.0.0.0/16 --vpc-peering-connection-id pcx-046f6b328e684fd90
```

### Create a route For vpc-b to vpc-a
```sh
aws ec2 create-route --route-table rtb-0ccffba76794b5947 --destination-cidr-block 10.0.0.0/16 --vpc-peering-connection-id pcx-046f6b328e684fd90
```

### Create a Two Template a and b yaml file
---

1. Template-a.yaml file for ec2 instance to monitoring or connect to the ec2-b
2. ec2-a connected by ssm manager to display the actual content serve by the ec2-b
3. ec2-b as a production instance serve the html page (apache2 installed on it)
4. Make wget -0q "http://45.94.12:123:80"
5. Can display the actual content serve by the vpc-2
