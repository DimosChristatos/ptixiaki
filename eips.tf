resource "aws_eip" "my_eip1"{
    vpc = true
    depends_on = [aws_internet_gateway.my_gateway]
}

resource "aws_eip" "my_eip2"{
    vpc = true
    depends_on = [aws_internet_gateway.my_gateway]
}