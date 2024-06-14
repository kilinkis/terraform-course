provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "web" {
    ami = "ami-00cf59bc9978eb266"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.webtraffic.name]
    user_data = file("server-script.sh")
    tags = {
        Name = "Web Server"
    }
}

resource "aws_eip" "web_ip" {
    instance = aws_instance.web.id
}


variable "ingress" {
    type = list(number)
    default = [80,443]
}

variable "egress" {
    type = list(number)
    default = [80,443]
}

resource "aws_security_group" "webtraffic" {
    name = "Allow Web traffic"

     dynamic "ingress" {
        iterator = port
        for_each = var.ingress
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

        dynamic "egress" {
        iterator = port
        for_each = var.egress
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}

output "PublicIP" {
    value = aws_eip.web_ip.public_ip
}

