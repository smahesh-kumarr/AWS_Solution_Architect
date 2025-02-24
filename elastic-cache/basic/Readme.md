# Create Serverless Cache

aws elasticache  create-serverless-cache \
--serverless-cache-name my-cache-87654 \ --major-engine-version 7

# Install Redis on Ubuntu

```sh
sudo apt-get install redis -y
```

```sh
redus-cli my-cache-ab-5432-ephlt6.serverless.ca1.cache/amazonaws.com:6379
```


```sh
docker compose up
```

# To auth to the redis cluster

```sh
redis-cli
```