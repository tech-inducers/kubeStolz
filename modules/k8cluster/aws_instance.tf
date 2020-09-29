/*
 * Copyright 2020 techinducers.com.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
 * Terraform ec2 declarations for AWS.
 */


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "k8-worker" {
  #count                       = var.aws_instance_count
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.aws_instance_type
  key_name                    = var.aws_key_name


  associate_public_ip_address = true
  private_ip                  = var.aws_vm_address
  subnet_id                   = aws_subnet.k8-subnet.id

  vpc_security_group_ids = [
  aws_security_group.aws-allow-icmp.id,
  aws_security_group.aws-allow-ssh.id,
  aws_security_group.aws-allow-vpn.id,
  aws_security_group.aws-allow-internet.id

  ]



  tags = {
    Name = "k8 controller on AWS"
  }
}



resource "aws_eip" "aws-ip" {
 vpc = true

 instance                  = aws_instance.k8-worker.id
 associate_with_private_ip = var.aws_vm_address
}
