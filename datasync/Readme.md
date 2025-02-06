## Data Sync Handson

```sh
aws s3 mb s3://souce-datasync-21345678
aws s3 mb s3://dest-datasync-7654321
```

# Upload File

```sh
touch hello.txt
aws s3 cp hello.txt s3://source-datasync-7654321/data/hello.txt
```