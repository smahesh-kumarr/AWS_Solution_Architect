#!/bin/bash

STACK_NAME=sns-lambda-stack
S3_BUCKET=my-bucket-09876545678

echo "Building the application..."
sam build

echo "Packaging the application..."
sam package --output-template-file packaged.yaml --s3-bucket $S3_BUCKET

echo "Deploying the application..."
sam deploy --template-file packaged.yaml --stack-name $STACK_NAME --capabilities CAPABILITY_IAM
