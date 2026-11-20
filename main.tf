data "aws_caller_identity" "current" {}

resource "aws_vpc" "school" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "it356-aa-school-vpc"
  }
}

resource "aws_subnet" "external" {
  vpc_id                  = aws_vpc.school.id
  cidr_block              = var.external_subnet_cidr
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "it356-external-subnet"
  }
}

resource "aws_subnet" "internal" {
  vpc_id            = aws_vpc.school.id
  cidr_block        = var.internal_subnet_cidr
  availability_zone = "us-east-2a"

  tags = {
    Name = "it356-internal-subnet"
  }
}

resource "aws_internet_gateway" "school" {
  vpc_id = aws_vpc.school.id

  tags = {
    Name = "it356-aa-school-igw"
  }
}

resource "aws_route_table" "external" {
  vpc_id = aws_vpc.school.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.school.id
  }

  tags = {
    Name = "it356-external-rt"
  }
}

resource "aws_route_table_association" "external" {
  subnet_id      = aws_subnet.external.id
  route_table_id = aws_route_table.external.id
}

resource "aws_route_table" "internal" {
  vpc_id = aws_vpc.school.id

  tags = {
    Name = "it356-internal-rt"
  }
}

resource "aws_route_table_association" "internal" {
  subnet_id      = aws_subnet.internal.id
  route_table_id = aws_route_table.internal.id
}

resource "aws_instance" "dc01" {
  ami           = "ami-0bd5573c3e7f438e6"
  instance_type = "c6i.xlarge"
  subnet_id     = aws_subnet.internal.id

  tags = {
    Name = "DC01"
    Role = "Domain Controller"
  }
}

resource "aws_instance" "dc02" {
  ami           = "ami-0bd5573c3e7f438e6"
  instance_type = "c6i.xlarge"
  subnet_id     = aws_subnet.internal.id

  tags = {
    Name = "DC02"
    Role = "Domain Controller"
  }
}

resource "aws_instance" "ca01" {
  ami           = "ami-0bd5573c3e7f438e6"
  instance_type = "c6i.xlarge"
  subnet_id     = aws_subnet.internal.id

  tags = {
    Name = "CA01"
    Role = "Certificate Authority"
  }
}

resource "aws_instance" "nps01" {
  ami           = "ami-0bd5573c3e7f438e6"
  instance_type = "c6i.xlarge"
  subnet_id     = aws_subnet.internal.id

  tags = {
    Name = "NPS01"
    Role = "NPS RADIUS"
  }
}

resource "aws_instance" "linux_ext_01" {
  ami           = "ami-08d70029f678429c4"
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.external.id

  tags = {
    Name = "LIN-EXT-01"
  }
}

resource "aws_instance" "linux_ext_02" {
  ami           = "ami-08d70029f678429c4"
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.external.id

  tags = {
    Name = "LIN-EXT-02"
  }
}

resource "aws_instance" "linux_int_01" {
  ami           = "ami-08d70029f678429c4"
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.internal.id

  tags = {
    Name = "LIN-INT-01"
  }
}

resource "aws_instance" "linux_int_02" {
  ami           = "ami-08d70029f678429c4"
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.internal.id

  tags = {
    Name = "LIN-INT-02"
  }
}