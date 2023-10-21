module "my_vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  tags = {
    Name       = "jhc-app-vpc"
    Department = "product-development"
  }
}
module "jhc_web" {
  source        = "./modules/ec2"
  ami           = "ami-0850b66899ab3b269"
  instance_type = "t2.micro"
  tags = {
    Name       = "jhc-app-ec2"
    Department = "product-development"
  }
  subnet_id = module.my_vpc.public_subnets[0]
}
