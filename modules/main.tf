provider "aws" {
  region = "eu-central-1"
}

module "ec2module" {
  source = "./ec2"
  ec2name = "Web Server"
}

output "name" {
  value = module.ec2module.instance_id
}