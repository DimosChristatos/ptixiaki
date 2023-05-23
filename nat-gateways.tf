resource "aws_nat_gateway" "my_gateway1"{
    allocation_id = aws_eip.my_eip1.id
    subnet_id = aws_subnet.my_public_subnet_1.id

    tags = {
        Name = "nat_gate_1"
    }
}

resource "aws_nat_gateway" "my_gateway2"{
    allocation_id = aws_eip.my_eip2.id
    subnet_id = aws_subnet.my_public_subnet_2.id

    tags = {
        Name  = "nat_gate_2"
    }
}