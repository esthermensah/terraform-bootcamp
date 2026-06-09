resource "aws_vpc" "main"{
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "terraform-vpc"
    }
}

resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "terraform-igw"
    }
}

resource "aws_route_table" "public_rt" {
   vpc_id = aws_vpc.main.id

   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
   }
   
   tags = {
    Name = "public-route-table"
   }
}


resource "aws_route_table_association" "public_a"{
   subnet_id = aws_subnet.public_a.id
   route_table_id = aws_route_table.public_rt.id

}



resource "aws_subnet" "public_a"{

    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = var.az_a
    map_public_ip_on_launch = true

    tags = {
        Name = "public-subnet-a"
    }
}


resource "aws_subnet" "public_b"{

    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone = var.az_b
    map_public_ip_on_launch = true

    tags = {
        Name = "public-subnet-b"
    }
}


resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.az_a

  tags = {
    Name = "private-subnet-a"
  }
}


resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = var.az_b

  tags = {
    Name = "private-subnet-b"
  }
}