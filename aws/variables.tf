//-------------------------------------------------------------------
// AWS settings
//-------------------------------------------------------------------


// Ubuntu LTS 14.04 - EBS-SSD (HVM)
variable "ami" {
  default = "ami-2b594f41"
  description = "AMI for Hugo"
}

variable "instance_type" {
  default = "t2.micro"
  description = "Instance type for Hugo instances"
}

variable "key_name" {
  default = "mimi"
  description = "SSH key name for hugo instances"
}

//-------------------------------------------------------------------
// VPC settings
//-------------------------------------------------------------------

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.30.0.0/16"
}

variable "public_subnet_cidr_hugo" {
  description = "CIDR for public subnet hugo"
  default     = "10.30.0.0/24"
}
