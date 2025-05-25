variable "instance_type" {
  description = "ec2-machine"
  type = string
  default = "t2.micro"
}

variable "ami" {
  description = "ec2 machine ami"
  type = string
  default = "ami-00575212298"
}

variable "key" {
  description = "ec2 key"
  type = string
  default = "nginx-key"
}