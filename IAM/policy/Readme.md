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