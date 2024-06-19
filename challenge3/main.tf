provider "aws" {
  region = "eu-central-1"
}

module "web" {
  source = "./web"
}

output "PublicIP" {
    value = module.web.pub_ip
}