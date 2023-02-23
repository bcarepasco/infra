variable "env_name" {
  type    = string
  default = "dev"
}

variable "identity_file" {
  type    = string
  default = "~/.ssh/terraform_root_user.pub"
}

variable "credentials" {
  type    = list(string)
  default = ["~/.aws/credentials"]
}

variable "availability_zone" {
  type    = string
  default = "ap-southeast-1a"
}

variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "profile" {
  type    = string
  default = "default"
}

variable "cidr_block" {
  type = object({
    vpc            = string
    public_subnet  = string
    private_subnet = string
  })
  default = {
    vpc            = "10.0.0.0/16"
    public_subnet  = "10.0.1.0/24"
    private_subnet = "10.0.2.0/24"
  }
}
