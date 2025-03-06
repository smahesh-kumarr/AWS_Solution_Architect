# AWS ECR: Mutable vs Immutable Tagging

AWS Elastic Container Registry (ECR) is a managed container image registry service. It provides options for **Mutable** and **Immutable** image tagging, allowing better version control and security.

## 1. Mutable vs Immutable Tagging

| Tag Type  | Description |
|-----------|-------------|
| **Mutable (Default)** | Allows overwriting an existing tag with a new image. Useful for CI/CD pipelines. |
| **Immutable** | Prevents overwriting an image tag once it is pushed. Ensures stability in production. |

### Example Usage
#### **Mutable Tagging (Overwriting the `latest` tag)**
```sh
docker tag myapp:v2 123456789012.dkr.ecr.us-east-1.amazonaws.com/myapp:latest
docker push 123456789012.dkr.ecr.us-east-1.amazonaws.com/myapp:latest
```
👉 **Result:** The `latest` tag now points to the new image.

#### **Immutable Tagging (Preventing Overwrites)**
- If immutability is enabled, pushing an image with the same tag fails.
```sh
docker tag myapp:v2 123456789012.dkr.ecr.us-east-1.amazonaws.com/myapp:v1.0
docker push 123456789012.dkr.ecr.us-east-1.amazonaws.com/myapp:v1.0
```
👉 **Result:** Push **fails** if `v1.0` already exists.

---

## 2. Public vs Private ECR Repository Privileges

| Feature       | **Public ECR Repo** | **Private ECR Repo** |
|--------------|----------------|----------------|
| **Access**   | Anyone can pull images (read-only) | Controlled via IAM policies |
| **Authentication** | No authentication required | Requires AWS IAM authentication |
| **Pull Limit** | No limits for anonymous users | No limit (IAM controlled) |
| **Push Permission** | Only repo owner can push | IAM policies define access |
| **Example URL** | `public.ecr.aws/myrepo/myapp:latest` | `123456789012.dkr.ecr.us-east-1.amazonaws.com/myrepo/myapp:latest` |

---

## 3. IAM Policies for ECR Access

### **Private Repository IAM Example**
To allow a user to **push and pull** images from a private ECR repo:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:CompleteLayerUpload",
        "ecr:GetDownloadUrlForLayer",
        "ecr:InitiateLayerUpload",
        "ecr:PutImage",
        "ecr:UploadLayerPart"
      ],
      "Resource": "*"
    }
  ]
}
```

### **Public Repository Policy Example**
To restrict public repo access:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Principal": "*",
      "Action": "ecr-public:PullImage",
      "Condition": {
        "StringNotEquals": {
          "aws:PrincipalArn": "arn:aws:iam::123456789012:user/allowed-user"
        }
      }
    }
  ]
}
```

---

## 4. Conclusion
- **Mutable tags** allow overwriting, suitable for CI/CD pipelines.
- **Immutable tags** prevent accidental overwrites, ensuring stability.
- **Private ECR** provides fine-grained access control via IAM policies.
- **Public ECR** allows unrestricted pulling but can be restricted via policies.

