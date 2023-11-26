resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.11.0/24"
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.12.0/24"
}