resource "aws_key_pair" "root" {
  key_name   = "root_keypair"
  public_key = file(var.identity_file)
}
