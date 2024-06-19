resource "aws_instance" "web" {
    ami = "ami-00cf59bc9978eb266"
    instance_type = "t2.micro"
    security_groups = [module.sg.sg_name]
    tags = {
        Name = "Web Server"
    }
}

output "pub_ip" {
  value = module.eip.PublicIP
}

module "eip" {
  source = "./eip"
  instance_id = aws_instance.web.id
}

module "sg" {
  source = "./sg"
}

