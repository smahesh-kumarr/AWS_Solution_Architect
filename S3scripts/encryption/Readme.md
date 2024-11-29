## Create a bucket

aws s3 mb s3://encryption-34232345

## Create a file

touch "Hi Bro" hello.txt

aws s3 cp hello.txt s3://encryption-34232345



## Create encryption key by kms

aws s3api put-object \
--bucket encryption-34232345 \
--key hello.txt \
--body hello.txt \
--server-side-encrytion aws:kms \
--sse-kms-key-id ["Give ur kms id if not get managed key by enabling the other bucket and use it for other one"]


## Enable Server Side encryption as default

aws s3api put-bucket-encryption \
--bucket encryption-34232345 \
--server-side-encryption-configuration '{
  "Rules": [
    {
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "aws:kms",
        "KMSMasterKeyID": "alias/aws/s3"
      }
    }
  ]
}'


## find the Kms id
aws kms list-keys
aws kms describe-key --key-id <key-id>

## Finally put an object 
aws s3api put-object \
--bucket encryption-34232345 \
--key hello.txt \
--body hello.txt \
--server-side-encryption aws:kms \
--ssekms-key-id <kms-key-id>

=============================================

### Put object with SSE-C( Not working)

export ENCODED_KEY=$(openssl rand -base64 32 )
echo $ENCODED_KEY

export md5_value =$(echo $ENCODED_KEY | base64 --decode | md5sum | awk '{print $1}' | base64 -w0)

aws s3api put-object \
--bucket encryption-34232345 \
--key hello.txt \
--body hello.txt \
--sse-customer-algorithm AES256
--sse-customer-key $ENCODED_KEY
--sse-customer-
--sse-customer-md5


## Make a visit AWS encryption SEE-C toturial (aws s3)

openssl rand -out ssec.key 32

## Upload
aws s3 cp hello.txt s3://encryption-34232345 \
--sse-c AES256 \
--sse-c-key fileb://sse.key


## Download
aws s3 cp  s3://encryption-34232345/hello.txt  \
--sse-c AES256 \
--sse-c-key fileb://sse.key