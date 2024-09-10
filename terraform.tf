terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-10"
    key = "any/terraform/remote/s3/terraform.tfstate"#path inside s3
    encrypt = true
    region = "us-east-1"
    # dynamodb_table = "terraform-state-locking"#make dynamo db table for state locking"{if two developer apply terraform plan at same it help to resolve conflict by adding terraform plan one by one}
  }
}