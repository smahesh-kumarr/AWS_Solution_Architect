## Create Pipeline

```sh
aws elastictranscoder create-pipeline \
    --name my-transocder-pipeline \
    --input-bucket salesoffice.example.com-source \
    --role arn:aws:iam::123456789012:role/Elastic_Transcoder_Default_Role \
    --content-config file://content-config.json \
    --thumbnail-config file://thumbnail-config.json
```