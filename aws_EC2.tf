
# locals {
#   myprivatekey = tls_private_key.pk.private_key_pem
#   }

resource "aws_instance" "bastion" {
    ami = var.EC2_AMI
  instance_type = var.EC2_TYPE
    associate_public_ip_address = true
    key_name = aws_key_pair.ec2.id
    subnet_id = module.network.pub_sub_1_id
    
  vpc_security_group_ids = [ aws_security_group.public-sec.id ]


  # user_data = "echo '${local.myprivatekey}' > /home/ec2-user/private_key2.pem"

    provisioner "local-exec" {
    command = "echo '${self.public_ip}' > ./inventory"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo '${tls_private_key.pk.private_key_openssh}' > /home/ec2-user/ec2-key.pem
              chmod 0400 /home/ec2-user/ec2-key.pem
              sudo dnf install mariadb105 -y
              EOF

  tags = {
    Name = "bastion"
  }
}


resource "aws_instance" "application" {
  count = var.EC2_COUNT
    ami = var.EC2_AMI
  instance_type = var.EC2_TYPE
    key_name = aws_key_pair.ec2.id
    subnet_id = module.network.priv_sub_1_id
  vpc_security_group_ids = [ aws_security_group.private-sec.id ]
  tags = {
    Name = "application"
  }
}