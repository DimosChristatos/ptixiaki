resource "aws_route_table_association" "public1-to-public-table"{
    subnet_id = aws_subnet.my_public_subnet_1.id
    route_table_id = aws_route_table.my_public_route_table.id
}

resource "aws_route_table_association" "public2-to-public-table"{
    subnet_id = aws_subnet.my_public_subnet_2.id
    route_table_id = aws_route_table.my_public_route_table.id
}

resource "aws_route_table_association" "private1-to-private-table1"{
    subnet_id = aws_subnet.my_private_subnet_1.id
    route_table_id = aws_route_table.my_private_route_table_1.id
}

resource "aws_route_table_association" "private2-to-private-table2"{
    subnet_id = aws_subnet.my_private_subnet_2.id
    route_table_id = aws_route_table.my_private_route_table_2.id    
}