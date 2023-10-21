# define variables for ec2 module
variable "ami" {
  type = string
}
variable "instance_type" {
  default = "t2.micro"
  type    = string
}
variable "tags" {
  default = {
    Name       = "jhc-app-ec2"
    Department = "product-development"
  }
  type = map(string)
}
variable "subnet_id" {
  type = string
}
