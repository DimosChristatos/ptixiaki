resource "aws_route_table" "my_public_route_table"{
    vpc_id = aws_vpc.my_vpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_gateway.id
    }

    tags = {
        Name = "public route table"
    }
}

resource "aws_route_table" "my_private_route_table_1"{
    vpc_id = aws_vpc.my_vpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.my_gateway1.id
    }

    tags = {
        Name = "private route table 1"
    }
}

resource "aws_route_table" "my_private_route_table_2"{
    vpc_id = aws_vpc.my_vpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.my_gateway1.id
    }

    tags = {
        Name = "private route table 2"
    }
}