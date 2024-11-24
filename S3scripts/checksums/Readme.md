## Create a new s3 bucket

```md
aws s3 mb s3://checksums-example-345432
```

## Create a file that will we do a checksum on

```
echo "Hello Bros" > myfile.txt
```

## Get a checksum of a file for md5
md5sum myfile.txt
e96574676b8306016e982e148485fe20  myfile.txt

## Upload our file
aws s3 cp myfile.txt s3://checksum-examples-345432
aws s3api head-object --bucket checksums-example-345432 --key myfile.txt

## Lets upload file with the different checksum

```
cksum -o 3 -b myfil.txt

ruby sha1_checksum.rb
e3d2c820d037b786c3b75e4f86647087b821109a
```

```sh
aws s3 put-object \
--bucket="checksums-example-345432" \
--key="myfile.txt" \
--body="myfilecrc32.txt" \
--checksum-algorithm="SHA1" \
--checksum-sha1 ="e3d2c820d037b786c3b75e4f86647087b821109a"
```