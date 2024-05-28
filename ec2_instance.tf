resource "aws_instance" "prashansa_instance" {
  count         = 1
  ami           = "ami-06d38e519dc8ebc68"
  instance_type = "t2.micro"
  # vpc_id                      = aws_vpc.prashansa_vpc.id
  subnet_id                   = aws_subnet.prashansa_publicSubnet.id
  key_name                    = "prashansa-key"
  associate_public_ip_address = "true"
  # vpc_security_group_ids      = [data.aws_security_group.launch-wizard-prashansa.id]
  root_block_device {
    volume_type           = "gp2"
    volume_size           = "9"
    delete_on_termination = true
  }
  # user_data = "#!/bin/bash\n\nsudo apt-get update\nsudo apt-get install -y apache2\n echo <html><h1>welcome to $(hostname -f )</h1></html> "
  # tags = {
  #   "Name" = "prashansa_tf_${count.index}"
  # }
}