resource "aws_subnet" "my_public_subnet_1"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.0.0/18"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
        Name = "my_public_subnet_1-east-1a"
        "kubernetes.io/role/elb" = "1" #https://docs.aws.amazon.com/eks/latest/userguide/network-load-balancing.html
        "kubernetes.io/cluster/eks" = "shared" #https://repost.aws/knowledge-center/eks-vpc-subnet-discovery
    }
}

resource "aws_subnet" "my_public_subnet_2"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.64.0/18"
    availability_zone = "us-east-1b"
    
    tags = {
        Name = "my_public_subnet_1-east-1b"
        "kubernetes.io/role/elb" = "1" #https://docs.aws.amazon.com/eks/latest/userguide/network-load-balancing.html
        "kubernetes.io/cluster/eks" = "shared" #https://repost.aws/knowledge-center/eks-vpc-subnet-discovery
    }
}

resource "aws_subnet" "my_private_subnet_1"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.128.0/18"
    availability_zone = "us-east-1a"

    tags = {
        Name = "my_private_subnet_1-east-1a"
        "kubernetes.io/role/internal-elb" = "1" #https://docs.aws.amazon.com/eks/latest/userguide/network-load-balancing.html
        "kubernetes.io/cluster/eks" = "shared" #https://repost.aws/knowledge-center/eks-vpc-subnet-discovery
    }
}

resource "aws_subnet" "my_private_subnet_2"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.192.0/18"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true

    tags = {
        Name = "my_private_subnet_1-east-1b"
        "kubernetes.io/role/internal-elb" = "1" #https://docs.aws.amazon.com/eks/latest/userguide/network-load-balancing.html
        "kubernetes.io/cluster/eks" = "shared" #https://repost.aws/knowledge-center/eks-vpc-subnet-discovery
    }
}