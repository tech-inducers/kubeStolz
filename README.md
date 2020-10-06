# kubeStolz
kubeStolz is hybrid multi cloud Kubernetes cluster

Deploy a multicloud dev Kubernetes Cluster (GCP vm and AWS ec2 and its vpn connection)


Quick Start
if you have questions, check the documentation and join us on the   #kubeStloz You can get your invite here

# Prerequisite

Install terraform

https://www.terraform.io/downloads.html

# Create cluster using kubespray

https://kubernetes.io/docs/setup/production-environment/tools/kubespray/

install ansible and jinja
Ansible v2.9 and python-netaddr is installed on the machine that will run Ansible commands
Jinja 2.11 (or newer) is required to run the Ansible Playbooks

# Terraform execution

go to dev directory
$terraform init

$terraform validate

$terraform plan

$terraform apply

# Kubespray execution

git clone https://github.com/kubernetes-sigs/kubespray.git
go to kubespray directory
Install dependencies from requirements.txt
sudo pip3 install -r requirements.txt

Copy inventory/sample  as inventory/mycluster
cp -rfp inventory/sample inventory/mycluster

# create inventory file
Example file
all:
  hosts:
    ip-10-0-0-25: (hostname defined in terraform for aws ec2)

      ansible_host: 54.200.87.20 (public ip of aws ec2)

      ansible_ssh_user: ubuntu (ec2 username defined in terraform)

      ansible_ssh_private_key_file: (file path to ec2 pem file
      ip: 10.0.0.25 (private ip of aws ec2)
      access_ip: 10.0.0.25 (private ip of aws ec2)

    gcp-vm-us-central1:
      ansible_host: 34.71.104.88 (public ip of gcp vm)
      ip: 10.240.0.100 (private ip of gcp vm)
      access_ip: 10.240.0.100 (private ip of gcp vm)

  children:
    kube-master:
      hosts:
        gcp-vm-us-central1: (master node we deined as gcp vm)

    kube-node:
      hosts:
        ip-10-0-0-25: (aws ec2 vm hostname)
        gcp-vm-us-central1: (gcp vm hostname)

    etcd:
      hosts:
gcp-vm-us-central1: (master hostname)

    k8s-cluster:
      children:
        kube-master:
        kube-node:
    calico-rr:
      hosts: {}


# check ssh connection of aws ec2 and gcp vm
ansible -i  path to hosts.yml file -m shell -a 'hostnamectl' all

# create cluster using kubespray ansible command
ansible-playbook -I path to hosts.yml file   --become --become-user=root cluster.yml

# rerun create cluster if it fails or skipped

# validate cluster creation

$kubectl get all --all-namespaces

if you find the The connection to the server localhost:8080 was refused - did you specify the right host or port?

Follow the following steps
# ssh to master node

$mkdir -p $HOME/.kube

$sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

$udo chmod 777 $HOME/.kube/config

$kubectl get all --all-namespaces
