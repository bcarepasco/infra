output "timescaledb_ip" {
  value = aws_instance.timescaledb.public_ip
}

# output "app_node_ip" {
#   value = aws_instance.app_node.public_ip
# }
