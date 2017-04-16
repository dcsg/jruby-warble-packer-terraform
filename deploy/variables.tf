variable "aws_access_key" {
  type = "string"
  description = "AWS Access Key"
}

variable "aws_secret_key" {
  type = "string"
  description = "AWS Secret Key"
}

variable "aws_region" {
  type = "string"
  description = "AWS Region"
}

variable "aws_key_path" {
  type = "string"
  description = "AWS Key path"
}
variable "aws_key_name" {
  type = "string"
  description = "AWS Key name"
}

variable "app_ami" {
  type = "string"
  description = "App AMI"
}

variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the Public Subnet"
  default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the Private Subnet"
  default = "10.0.1.0/24"
}
