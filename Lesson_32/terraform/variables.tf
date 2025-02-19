variable "region" {
  description = "Region"
  type = string
  default = "ap-southeast-1"
}

variable "ami" {
  description = "ami"
  type = string
#   default = "ami-0474ac020852b87a9"
}

variable "instance_type" {
  description = "instance_type"
  type = string
#   default = "t2.micro"
}