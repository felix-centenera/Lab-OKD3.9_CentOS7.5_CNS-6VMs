#!/bin/bash

## Install Ansible in node bastion


yum update -y
yum upgrade -y
yum --enablerepo=extras install epel-release -y

yum -y  install  pyOpenSSL python-pip python-dev sshpass git python-gssapi
sudo mkdir -p /etc/ansible
sudo -H pip install --upgrade pip
sudo -H pip install --upgrade setuptools
sudo -H pip install ansible==2.6.5
# sudo -H pip install python-gssapi
sudo mv /tmp/ansible.cfg /etc/ansible/
sudo mv /tmp/ansible /root/
sudo git clone https://github.com/openshift/openshift-ansible.git /root/release-3.9 -b release-3.9
ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa

for host in master-one.192.168.33.2.xip.io lb-one.192.168.33.7.xip.io master-two.192.168.33.3.xip.io master-three.192.168.33.4.xip.io infra.192.168.33.5.xip.io app-one.192.168.33.6.xip.io; do sshpass -f /tmp/password.txt ssh-copy-id -o "StrictHostKeyChecking no" -f $host ; done
