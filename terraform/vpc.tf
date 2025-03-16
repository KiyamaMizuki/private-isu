resource "aws_vpc" "vpc" {
    cidr_block = "10.10.0.0/16"
}

# Private-isu用サブネット環境
resource "aws_subnet" "public_1a" {
    vpc_id = aws_vpc.vpc.id

    availability_zone = "ap-northeast-1a"
    cidr_block = "10.10.0.0/24"
}

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "public_1a_rtb" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }
}

resource "aws_route_table_association" "a" {
    subnet_id      = aws_subnet.public_1a.id
    route_table_id = aws_route_table.public_1a_rtb.id
}

# ベンチマーク用サブネット環境