resource "aws_db_subnet_group" "prashansa_db_rds" {
  name       = "prashansa_rds"
  subnet_ids = [
    aws_subnet.prashansa_privateSubnet1.id,
    aws_subnet.prashansa_privateSubnet2.id
  ]
}
resource "aws_db_instance" "prashansa_db_rds" {
  engine               = "mysql"
  identifier           = "prashansa-instance"
  allocated_storage    = "5"
  engine_version       = "8.0.32"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "admin123"
  db_subnet_group_name = aws_db_subnet_group.prashansa_db_rds.name
  skip_final_snapshot  = true
  publicly_accessible  = false
  tags = {
    "Name"  = "prashansa_db_rds"
    "owner" = "prashansa.joshi"
  }
}