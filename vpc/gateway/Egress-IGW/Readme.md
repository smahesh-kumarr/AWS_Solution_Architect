### Create a Vpc Ec2

```sh
aws ec2 create-vpc --cidr-block 10.0.0.0/16 --amazon-provided-ipv6-cidr-block
```

### Create a Subnet with the specifief Ipv6 and Ipv4
```sh
aws ec2 create-subnet --vpc-id vpc-0abcd1234efgh5678 \
--ipv6-cidr-block 2600:1f18:abcd:1234::/64 \
--availability-zone us-west-1a
```
### We need a DNs 64

```sh
aws ec2 modify-subnet-attribute --subnet-id subnet-09fg4543d2344ef --enable-dns64
```

### Create a Egress-igw

```sh
aws ec2 create-egress-only-internet-gateway --vpc-id vpc-0abcd1234efgh5678
```

### Attach Internet Gateway to Vpc

```sh
aws ec2 attach-internet-gateway --internet-gateway-id igw-0abcd1234efgh5678 --vpc-id vpc-0abcd1234efgh5678
```

### Allocate Elastic-Ip
```sh
aws ec2 allocate-address --domain vpc
```

### create NAT Gateway

```sh
aws ec2 create-nat-gateway --subnet-id subnet-0abcd1234efgh5678 --allocation-id eipalloc-0abcd1234efgh5678
```

### Create a Route table

```sh
aws ec2 create-route-table --vpc-id vpc-0abcd1234efgh5678
```
### Create a Route For IPv6

```sh
aws ec2 create-route --route-table-id rtb-0abcd1234efgh5678 --destination-ipv6-cidr-block ::/0 --egress-only-internet-gateway-id eigw-0abcd1234efgh5678
```

### Create a Route For IPv4
```sh
aws ec2 create-route --route-table-id rtb-0abcd1234efgh5678 --destination-cidr-block 0.0.0.0/0 --gateway-id igw-0abcd1234efgh5678
```

### Add Manual config in UI route config
- 0.0.0.0/0 → Internet Gateway (for IPv4)
- ::/0 → Egress-Only Internet Gateway (for IPv6)
- 64:ff9b::/96 → NAT Gateway (to support IPv6-to-IPv4 translation)

### Rest of all step in Console

- Create a EC2 with SSM Manger Role
- Connect to it and configure it 
- curl config.me to see


### Architecture Diagram Overview:

- VPC with both IPv4 and IPv6 CIDR blocks.
- Subnets with IPv4 and IPv6 configurations.
- Public Subnet with an Internet Gateway for IPv4 traffic and a NAT Gateway for private instances to access the internet.
- Private Subnet with an Egress-Only Internet Gateway for outbound IPv6 traffic.
- NAT Gateway for IPv4 traffic from private instances.
- Routing configured for IPv4 and IPv6 traffic, ensuring secure and controlled access to the internet.
- EC2 Instances can connect securely through SSM or via the internet depending on their IP configuration (IPv4 or IPv6).