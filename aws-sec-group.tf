resource "aws_security_group" "public-sec" {
  name        = "allow_outside-traffic2"
  description = "allow_outside-traffic2"
  vpc_id      = module.network.vpc_id

  ingress {
    description      = "ssh from outside"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "public-sec"
  }
}

resource "aws_security_group" "private-sec" {
  name        = "allow_inside-traffic"
  description = "allow_inside-traffic"
  vpc_id      = module.network.vpc_id

  ingress {
    description      = "ssh from inside"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [module.network.vpc_cidr]
  }


  ingress {
    description      = "from vpc"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = [module.network.vpc_cidr]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "private-sec"
  }
}

resource "aws_security_group" "mysql-sec" {
  name        = "mysql-security-group"
  description = "mysql-security-group"
  vpc_id      = module.network.vpc_id

  ingress {
    description      = "ssh from inside"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [module.network.vpc_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "private-sec"
  }
}

resource "aws_security_group" "elastic-sec" {
  name        = "elastic-cache-security-group"
  description = "elastic-cache-security-group"
  vpc_id      = module.network.vpc_id

  ingress {
    description      = "ssh from inside"
    from_port        = 6379
    to_port          = 6379
    protocol         = "tcp"
    cidr_blocks      = [module.network.vpc_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "private-sec"
  }
}
