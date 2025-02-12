
## Create s s3 bucket

```sh 
aws s3 mb s3://videos.example23456789.com --region us-east-1
```

```sh
aws s2 cp Sample.mp4 s3://videos.example23456789.com --region us-east-1
```

## Create Pipeline


```sh
aws elastictranscoder create-pipeline \
    --name my-transocder-pipeline \
    --input-bucket svideos.example23456789.com \
    --role arn:aws:iam::982383527471:role/Elastic_Transcoder_Default_Role \
    --content-config file://content-config.json \
    --thumbnail-config file://thumbnail-config.json
```

## Create a Jon

```sh
aws elastictranscoder create-job \
    --pipeline-id 1713880324998-qws2vn \
    --inputs file://inputs.json \
    --outputs file://outputs.json \
    --output-key-prefix "recipes/" \
    --user-metadata file://user-metadata.json
    --query Job.Id
```


## Read-job

```sh
aws elastuctranscoder read-job --id 1713880324998-qws2vn --region us-east-1
```