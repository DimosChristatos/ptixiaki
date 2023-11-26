resource "aws_eip" "my_eip" {
  instance = aws_lb.my_alb.id
}