# Create a SubnetGroup

aws memorydb create-subnet-group \
    --subnet-group-name mysubnetgroup \
    --description "my subnet group" \
    --subnet-ids subnet-0e0fd31733061237d subnet-0377c6b172e2951d4 \
    --query SubnetGroup.ARN
    --output text

# Create user
aws memorydb create-user \
    --user-name maheshkumarr \
    --access-string "on ~* &* +@all" \
     --authentication-mode \
         Passwords="Testing1234568765487567890!",Type=password

# Create a ACL
aws memorydb create-acl \
    --acl-name "new-acl-1" \
    --user-names "maheshkumarr"

# Create a cluster
aws memorydb create-cluster \
    --cluster-name my-new-cluster \
    --node-type db.t4g.small \
    --acl-name new-acl-1 \
    --subnet-group my-subnetgroup