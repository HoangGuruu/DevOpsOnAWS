module "ec2" {
  source = "../"
  ami= var.ami_module
  instance_type = var.instance_type_module
}