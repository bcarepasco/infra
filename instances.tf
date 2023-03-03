resource "aws_instance" "timescaledb" {
  instance_type          = var.instance_type
  ami                    = data.aws_ami.timescaledb.id
  key_name               = aws_key_pair.root.key_name
  vpc_security_group_ids = [aws_security_group.timescaledb_security_group.id]
  subnet_id              = aws_subnet.public_subnet.id
  user_data              = file("templates/timescaledb.tpl")

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }

  ebs_block_device {
    device_name           = "/dev/sdh"
    delete_on_termination = false
    volume_size           = 10

    tags = {
      Name = "${var.env_name}-timescaledb-ebs-volume"
    }
  }

  tags = {
    Name = "${var.env_name}-timescaledb"
  }
}

# resource "aws_ebs_volume" "timescaledb_volume" {
#   availability_zone = var.availability_zone
#   size              = 10

#   tags = {
#     Name = "timescaledb-ebs-volume"
#   }
# }

# resource "aws_volume_attachment" "timescaledb_ebs_att" {
#   device_name = "/dev/sdh"
#   volume_id   = aws_ebs_volume.timescaledb_volume.id
#   instance_id = aws_instance.timescaledb.id
#   skip_destroy =  true
#   stop_instance_before_detaching = true
# }

# resource "aws_instance" "app_node" {
#   instance_type          = var.instance_type
#   ami                    = data.aws_ami.ubuntu20.id
#   key_name               = aws_key_pair.root.key_name
#   vpc_security_group_ids = [aws_security_group.app_node_security_group.id]
#   subnet_id              = aws_subnet.public_subnet.id
#   user_data              = file("user_data.tpl")

#   root_block_device {
#     volume_size = 10
#   }

#   tags = {
#     Name = "${var.env_name}-app-node"
#   }
# }
