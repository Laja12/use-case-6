terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

module "aurora_cluster" {
  source = "./modules/aurora"

  cluster_identifier = "example-aurora-cluster"
  engine             = "aurora-mysql"
  engine_version     = "5.7.mysql_aurora.2.11.1"
  instance_class     = "db.r6g.large"
  db_name            = "exampledb"
  username           = "auroraadmin"
  secret_name        = "aurora-db-credentials2"
  
}
