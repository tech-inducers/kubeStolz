/*
 * Copyright 2020 techinducers Inc.
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

module "Controller-netwrok-aws"{
source               = "../modules/k8cluster/"



}
/*
resource "null_resource" "validate-server-ssh" {


  provisioner "local-exec" {
    command = "ansible -i /Users/soumya/workspace/Kube_poc/kubespray/inventory/kubstloz/host.yml -m shell -a 'hostnamectl' all"
  }
}


resource "null_resource" "k8-creation" {


  provisioner "local-exec" {
    command = "ansible-playbook -i /Users/soumya/workspace/kube_poc/kubespray/inventory/kubstloz/host.yml  --become --become-user=root /Users/soumya/workspace/kube_poc/kubespray/cluster.yml"
  }
}
 */
