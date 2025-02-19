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

