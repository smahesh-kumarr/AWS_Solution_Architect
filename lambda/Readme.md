# AWS Lambda Alias & Versions - Mini Notes

## 📌 What is an AWS Lambda Alias?
- An **alias** is a named pointer to a specific **Lambda function version**.
- Used to manage **deployments**, **traffic shifting**, and **version control**.

## 📌 Lambda Versions: Qualified vs. Unqualified
| Type                  | Description                                      | Example ARN |
|----------------------|------------------------------------------------|------------|
| **Unqualified ARN**  | Points to the **latest** version of a function | `arn:aws:lambda:us-east-1:123456789012:function:MyLambda` |
| **Qualified ARN**    | Points to a **specific** published version | `arn:aws:lambda:us-east-1:123456789012:function:MyLambda:1` |

🔴 **Aliases require a qualified version (e.g., `:1`, `:2`) and cannot point to an unqualified ARN.**

---

## 📌 Creating Lambda Versions
### 1️⃣ Publish a new version
```sh
aws lambda publish-version --function-name MyLambda
```
### 2️⃣ List available versions
```sh
aws lambda list-versions-by-function --function-name MyLambda
```

---

## 📌 Creating & Managing Aliases
### 1️⃣ Create an alias pointing to a specific version
```sh
aws lambda create-alias --function-name MyLambda --name Prod --function-version 2
```
✅ Alias `Prod` now points to **Version 2**

### 2️⃣ View alias details
```sh
aws lambda get-alias --function-name MyLambda --name Prod
```

### 3️⃣ Update alias to shift traffic (Canary Deployment)
```sh
aws lambda update-alias --function-name MyLambda --name Prod \
  --routing-config '{"AdditionalVersionWeights": {"3": 0.1}}'
```
✅ 90% traffic → Version 2
✅ 10% traffic → Version 3

### 4️⃣ Delete an alias
```sh
aws lambda delete-alias --function-name MyLambda --name Prod
```

---

## 📌 Summary
✅ **Aliases provide a stable way to reference Lambda versions**  
✅ **Aliases work only with qualified versions**  
✅ **Traffic shifting allows gradual rollouts for new Lambda versions** 🚀

# AWS Lambda Layers - Complete Guide

## 📌 What are AWS Lambda Layers?
AWS Lambda **Layers** allow you to package external dependencies, custom runtimes, or shared code **separately** from your Lambda function code. This makes deployments more efficient and helps you reuse code across multiple functions.

## 🎯 Why Use Lambda Layers?
- **Reduces Deployment Package Size** – Avoid bundling the same libraries multiple times.
- **Easier Updates** – Update a shared layer instead of modifying all Lambda functions.
- **Speeds Up Development** – Reuse common dependencies across projects.
- **Supports Custom Runtimes** – Extend AWS Lambda with your own execution environment.

## 🏗️ How AWS Contributes to Layers
AWS provides **pre-built layers** to help developers get started:
- **AWS SDK Layer** – Pre-installed AWS SDKs for easier service integration.
- **Machine Learning Layers** – Pre-packaged ML libraries.
- **Security & Monitoring Layers** – Tools like logging, tracing, and security monitoring.
- **Community & Custom Layers** – Developers can create, share, and reuse custom layers.

## 🛠️ Creating and Using a Lambda Layer

### 1️⃣ **Create a ZIP File for the Layer**
```sh
mkdir -p python/lib/python3.8/site-packages
pip install numpy -t python/lib/python3.8/site-packages/
zip -r numpy-layer.zip python
```

### 2️⃣ **Publish the Layer in AWS Lambda**
```sh
aws lambda publish-layer-version \
  --layer-name numpy-layer \
  --description "NumPy for Python 3.8" \
  --content S3Bucket=my-bucket,S3Key=numpy-layer.zip \
  --compatible-runtimes python3.8
```

### 3️⃣ **Attach the Layer to a Lambda Function**
```sh
aws lambda update-function-configuration \
  --function-name MyLambdaFunction \
  --layers arn:aws:lambda:us-east-1:123456789012:layer:numpy-layer:1
```

### 4️⃣ **List Available Layers**
```sh
aws lambda list-layers
```

## 🔍 Lambda Layer Limits
- **Maximum 5 layers** can be attached to a single function.
- **Total unzipped size limit: 250 MB** (including function code + layers).

## ✅ Summary
- **AWS Lambda Layers help modularize and optimize deployments.**
- **Reduce redundancy and manage dependencies efficiently.**
- **AWS offers pre-built layers, and you can create custom ones.**

🚀 **Start using Lambda Layers today to make your serverless applications more efficient!**


# AWS Lambda - OS-Only Runtimes

## Overview
AWS Lambda provides OS-Only Runtimes for cases where a pre-installed programming language runtime is not available. These runtimes allow developers to bring their own runtime, compile binaries, or use third-party solutions.

## When to Use OS-Only Runtimes
There are three main scenarios where OS-Only Runtimes are beneficial:

### 1. Native Ahead-of-Time (AOT) Compilation
Languages that compile into an **executable binary** that does not require a dedicated language runtime.
- **Supported Languages**: Go, Rust, C++, .NET Native AOT, Java GraalVM Native
- **Requirements**:
  - Include the AWS Lambda Runtime API interface in your binary.
  - Compile the binary for Amazon Linux’s architecture.

### 2. Third-Party Runtimes
Some programming languages are **not natively supported** by AWS but have community-maintained runtimes.
- **Examples**:
  - Bref (for PHP)
  - Swift AWS Lambda Runtime

### 3. Custom Runtimes
If AWS Lambda **does not provide a managed runtime** for a specific language or version, you can create your own.
- **Use Cases**:
  - Running newer versions of languages not yet supported by AWS.
  - Running completely different languages like COBOL or Dart.
- **Requirements**:
  - Build a custom runtime that interacts with the AWS Lambda Runtime API.

## Available OS-Only Runtimes
AWS Lambda provides the following OS-Only Runtimes:

| OS-Only Runtime   | Identifier     |
|------------------|---------------|
| Amazon Linux 2  | provided.al2  |
| Amazon Linux 2023 | provided.al2023 |

## Why Use OS-Only Runtimes?
- ✅ **Flexibility** – Run any programming language, even if AWS doesn’t officially support it.
- ✅ **Performance** – Precompiled binaries run faster than interpreted languages.
- ✅ **Smaller Deployments** – Binaries take up less space than full runtimes.
- ✅ **Customization** – Choose exactly which dependencies and libraries are included.

## Conclusion
AWS Lambda OS-Only Runtimes provide **full control** over the runtime environment, allowing developers to use precompiled binaries, third-party runtimes, or custom runtime implementations.

---
🚀 **Build your own runtime and extend AWS Lambda beyond its default limitations!**
