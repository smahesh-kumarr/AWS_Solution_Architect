create_vpc.sh:
Create a VPC: Set up a private network within AWS.
Create an Internet Gateway (IGW): Allow internet access to the VPC.
Create a Subnet: Allocate a range of IP addresses within the VPC.
Modify Subnet Attributes: Enable public IP assignment for instances.
Create and Associate Route Table: Ensure that traffic is routed to the internet via the IGW.

delete_vpc.sh:
Detach the IGW: Remove the IGW from the VPC.
Delete the IGW: Clean up the IGW resource.
Disassociate Subnet from Route Table: Remove the route association.
Delete the Subnet: Remove the subnet from the VPC.
Delete the Route Table: Clean up the route table.
Delete the VPC: Finally, delete the VPC once all resources have been removed.