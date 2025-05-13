resource "aws_instance" "web" {
  ami                         = "ami-0505850c059a7302e" #Private-isu-AMI
  instance_type               = "c7a.large"
  iam_instance_profile        = aws_iam_instance_profile.example_profile.name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web.id]
  subnet_id                   = aws_subnet.public_1a.id
  user_data                   = <<-EOF
        snap install amazon-ssm-agent --classic
        snap start amazon-ssm-agent

    EOF
  tags = {
    Name = "Private-isu"
  }
}

resource "aws_instance" "benchmark" {
  ami                         = "ami-0505850c059a7302e" #Private-isu-AMI
  instance_type               = "c7a.xlarge"
  iam_instance_profile        = aws_iam_instance_profile.example_profile.name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.benchmark.id]
  subnet_id                   = aws_subnet.public_1a.id
  user_data                   = <<-EOF
        snap install amazon-ssm-agent --classic
        snap start amazon-ssm-agent

    EOF
  tags = {
    Name = "Private-isu-benchmark"
  }
}
