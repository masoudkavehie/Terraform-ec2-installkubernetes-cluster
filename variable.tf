variable "ami" {
  default = "ami-022e1a32d3f742bd8"
}
variable "instance_type" {

  default = "t2.micro"

}
variable "instance_name" {
  default = "web-server"
}
variable "createby" {
  default = "masoudkaveh"
}
variable "web-servers" {
  type = list(string)
}
variable "key_name" {
}
variable "region" {
  default = "us-east-1"
}
# variable "password" {
#   type = string
# }
# variable "host" {

# }
variable "playbook_path" {
  description = "/home/masoud/masoud/kuber-ansible/playbook.yaml"
  default     = "/home/masoud/masoud/kuber-ansible/playbook.yaml"
}

