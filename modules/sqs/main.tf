provider "aws" {
  access_key = ""
  secret_key = ""
  token      = ""
  region     = "us-east-1"
}


resource "aws_sqs_queue" "terraform_queue" {
  name                              = "terraform-example-queue.fifo"
  fifo_queue                        = true
  content_based_deduplication       = true
  delay_seconds                     = 0
  receive_wait_time_seconds         = 0 
  visibility_timeout_seconds        = 30
  message_retention_seconds         = 345600
  max_message_size                  = 262144
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter_queue.arn,
    maxReceiveCount     = 3
  })
  tags = {
    Name = "fifo"
  }
}

resource "aws_sqs_queue" "deadletter_queue" {
  name                              = "dlq.fifo"
  visibility_timeout_seconds        = 30
  message_retention_seconds         = 345600
  fifo_queue                        = true
  content_based_deduplication       = true
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300
  max_message_size                  = 262144
}