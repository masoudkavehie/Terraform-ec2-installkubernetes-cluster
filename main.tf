resource "aws_instance" "webserver" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Created_By = var.createby
    Name       = "server ${var.web-servers[count.index]}"
  }
  count = 3
  # key_name = var.key_name
  #   user_data = <<-EOT
  #             #!/bin/bash
  #             sudo yum update -y
  #             sudo yum install -y ansible

  #             # Place your Ansible playbook content here (base64 encoded)
  #             echo 'BASE64_ENCODED_PLAYBOOK_CONTENT' | base64 -d > playbook.yml

  #             # Run the Ansible playbook
  #             ansible-playbook playbook.yml
  #             EOT

  #   lifecycle {
  #     prevent_destroy = true
  #   }
}


locals {
  all_ips = aws_instance.webserver[*].public_ip
}

resource "local_file" "ip" {
  content  = join("\n", local.all_ips)
  filename = "ip.txt"
}


resource "null_resource" "ansible_local" {
  depends_on = [local_file.ip]
  provisioner "local-exec" {
    command = "ansible-playbook -i '${join(",", local.all_ips)}' ${var.playbook_path}"
  }
}



#importing import aws_instance.webserver2 i-01c5fc8f24e777748
# resource "aws_instance" "webserver2" {
#   ami           = var.ami
#   instance_type = var.instance_type
#   key_name      = var.key_name

# }
# resource "aws_s3_bucket" "masoud3-bucket" {
#   bucket = "my-tf-test-bucket"
#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }