## Convert to json

```sh
yq -o json policy.yml > policy.json
```

```sh
./convert
```

## Create IAM Policy

```sh
aws iam create-policy \
--policy-name my-policy \
--policy-document file://policy.json
```


# Attach policy to user

```sh
aws iam attach-user-policy \
--policy-arn arn:aws:iam::aws:my-policy \
--user-name Alice
```


# Delet policy to user

```sh
aws iam delete-policy-version --policy-arn arn:aws:iam::123456789012:policy/MyPolicy --version-id v1
aws iam delete-policy-version --policy-arn arn:aws:iam::123456789012:policy/MyPolicy --version-id v2
aws iam delete-policy-version --policy-arn arn:aws:iam::123456789012:policy/MyPolicy --version-id v3
```