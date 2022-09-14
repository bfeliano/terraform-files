resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "key_shares_artifacts"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "keyId"

  server_side_encryption {
        enabled     = true
        }


  attribute {
    name = "keyId"
    type = "S"
  }
/*
  attribute {
    name = "crypto"
    type = "S"
  }


  attribute {
    name = "wallet"
    type = "S"
  }
*/

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }



  tags = {
    Name        = "key_shares_artifacts"
    Environment = "production"
  }
}


/*
module "dynamodb" {
  source             = "../modules/dynamodb"
}
*/