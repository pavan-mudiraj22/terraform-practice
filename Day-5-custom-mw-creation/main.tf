#creation of vpc
resource "aws_vpc" "custom_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "custom-vpc"
    }
}

#creation of subnet
resource "aws_subnet" "custom_subnet" {
    vpc_id = aws_vpc.custom_vpc.id
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "subnet-1"
    }
}
#creation of internet gateway
resource "aws_internet_gateway" "custom_igw" {
    vpc_id = aws_vpc.custom_vpc.id
    tags = {
        Name = "my-igw"
    }
}

#creation of route table
resource "aws_route_table" "custom_rt" {
    vpc_id = aws_vpc.custom_vpc.id
    tags = {
        Name = "my-rt"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.custom_igw.id
    }
}
resource "aws_route_table_association" "custom_rta" {
    subnet_id = aws_subnet.custom_subnet.id
    route_table_id = aws_route_table.custom_rt.id
}

#creation of security group
resource "aws_security_group" "custom_sg" {
    name = "my-sg"
    description = "Allow SSH and HTTP"
    vpc_id = aws_vpc.custom_vpc.id

    ingress {
        from_port = 22   #SSH port
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80   #HTTP port
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0 #any port
        to_port = 0
        protocol = "-1" #any protocol
        cidr_blocks = ["0.0.0.0/0"] #any source
    }
}

#creation of ec2 instance
resource "aws_instance" "custom_instance" {
    ami = "ami-0857ef7554aab20ef"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.custom_subnet.id
    vpc_security_group_ids = [aws_security_group.custom_sg.id]
    tags = {
        Name = "my-instance"
    }
}