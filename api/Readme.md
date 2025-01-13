## Create a new user with no permission 

We need to create a new user with no permission and generate out access keys

```sh
aws iam create-user --user-name sts-machine-user-45678
aws iam create-access-key --user-name sts-machine-user-45678 --output table
```


## Then edit credentials file to change away from default profile
```sh
open ~/.aws/credentials
```

## Test Who you are
```sh
aws sts get-caller-identity --profile sts
```

## Make sure you don't have access to s3
```sh
aws s3 ls --profile sts
```

## Use new user credentials and assume role