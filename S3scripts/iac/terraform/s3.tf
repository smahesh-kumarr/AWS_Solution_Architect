resource "aws_s3_bucket" "my-s3-sample-2345" {

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}