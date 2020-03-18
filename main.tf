terraform {
  backend "s3" {
    bucket = "bot-terraform-use1"
    key    = "tfstate/trebot/tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"
  name                   = "use1-bot-01"
  instance_count         = 1
  ami                    = "ami-046842448f9e74e7d"
  instance_type          = "t3.micro"
  key_name               = "sloth-access-only"
  monitoring             = false
  subnet_id              = "subnet-xxxxxxxxxx"
  ebs_optimized          = "true"
  user_data              = "${file("user_data")}"

  tags = {
    Terraform   = "true"
    Environment = "trolling"
  }
}
