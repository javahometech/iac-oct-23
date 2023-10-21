variable "vpc_cidr" {
  default = "10.0.0.0/16"
  type    = string
}
variable "tags" {
  default = {
    Name       = "jhc-app-vpc"
    Department = "product-development"
  }
  type = map(string)
}
