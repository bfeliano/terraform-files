provider "aws" {

}


resource "aws_s3_bucket" "example" {
  bucket = "example"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.example.id
  acl    = "private"
}




resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}


resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = (aws_s3_bucket.example.id)
  policy = file("./policy.json")
}

