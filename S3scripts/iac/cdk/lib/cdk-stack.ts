import * as s3 from 'aws-cdk-lib/aws-s3';
import { Stack, StackProps } from 'aws-cdk-lib';
import { Construct } from 'constructs';

export class CdkStack extends Stack {
  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props);

    const bucket = new s3.Bucket(this, 'MyBucket');
  }
}

// Install AWS CDK and set up the environment.
// Bootstrap the environment using cdk bootstrap (sets up the resources AWS CDK needs).
// Define your infrastructure using CDK (e.g., S3 bucket).
// Synthesize the CloudFormation template using cdk synth.
// Deploy the resources using cdk deploy.
// Manage and update resources via cdk deploy and delete with cdk destroy.

// When you run the cdk synth command, AWS CDK takes your code and generates a CloudFormation template based on it.
//  This template is written in YAML or JSON and describes the AWS resources and their configurations.