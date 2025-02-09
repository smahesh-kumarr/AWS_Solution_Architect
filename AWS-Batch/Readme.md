# Register Job

aws batch register-job-definition \
    --job-definition-name square-job \
    --type container \
    --container-prperties '{"image": "9873456771.dkr.ecr,us-east-1.amazonaws.com/square",
    "vcpus": 1,
    "memory": 128}'


# Create Comput Env (or) Create Through Console
aws batch create-compute-environment \
    --compute-environment-name MyComputeEnv \
    --type MANAGED \
    --state ENABLED \
    --compute-resources "{
        \"type\": \"EC2\", 
        \"minvCpus\": 0, 
        \"maxvCpus\": 16, 
        \"desiredvCpus\": 8, 
        \"instanceTypes\": [\"m5.large\"], 
        \"subnets\": [\"subnet-xxxxxxxx\"], 
        \"securityGroupIds\": [\"sg-xxxxxxxx\"], 
        \"instanceRole\": \"arn:aws:iam::123456789012:instance-profile/AWSBatchInstanceRole\",
        \"tags\": {\"Project\": \"MyBatchProject\"}
    }" \
    --service-role "arn:aws:iam::123456789012:role/AWSBatchServiceRole"


# Create a Queue 

aws batch create-job-queue \
--job-queue-name my-job-queue \
--state ENABLED \
--priority 1 \
--compute-environment-order '[
    {
        "order": 1,
        "computeEnvironment": "arn:aws:batch:ca-central-1:98767834771":compute-environment/ComputeEnv"
    }
]'


# Submit Job

aws batch submit-job \
    --job-name my-job \
    --job-defintion square-job
    --job-queue my-job-queue

# Docker Login

aws ecr get-login-password \
    --region region | docker login \
    --username AWS \
    --password-stdin aws_account_id.dkr.ecr.region.amazonaws.com

# Create a Image Tag
docker tag e9ae3c220b23 aws_account_id.dkr.ecr.region.amazonaws.com/my-repository:tag

# Push to the registry
docker push aws_account_id.dkr.ecr.region.amazonaws.com/my-repository:tag