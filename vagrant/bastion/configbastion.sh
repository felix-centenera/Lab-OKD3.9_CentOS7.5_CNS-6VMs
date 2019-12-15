#!/bin/bash

## Install Ansible in node bastion


yum update -y
yum upgrade -y
yum --enablerepo=extras install epel-release -y

yum -y  install  pyOpenSSL python-pip python-dev sshpass  python-gssapi
sudo mkdir -p /etc/ansible
sudo -H pip install --upgrade pip
sudo -H pip install --upgrade setuptools
sudo -H pip install ansible==2.6.5
sudo mv /tmp/ansible.cfg /etc/ansible/
sudo mv /tmp/ansible /root/
ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa

##ALLOW root login & password PasswordAuthentication

sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd

for host in master-one.192.168.33.2.xip.io lb-one.192.168.33.7.xip.io master-two.192.168.33.3.xip.io master-three.192.168.33.4.xip.io infra.192.168.33.5.xip.io app-one.192.168.33.6.xip.io; do sshpass -f /tmp/password.txt ssh-copy-id -o "StrictHostKeyChecking no" -f $host ; done
