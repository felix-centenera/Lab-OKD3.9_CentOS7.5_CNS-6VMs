Deploy OKD 3.9  (Free OpenShift 3.9)  & CentOS 7 & VirtualBox & Vagrant & Ansible
========================================

Description
--------------------------------
This document describe the process to install OKD 3.9 (Free OpenShift 3.9) in VirtualBox. Vagrant generate the VMs and resources for us. Ansible will install requistes and OKD 3.9 for us.


Requirements
--------------------------------
VirtualBox 5.2.18

Vagrant version: Installed Version: 2.0.4

    Vagrant  plugins:

        vagrant-disksize (0.1.2)

        vagrant-hostmanager (1.8.9)

        vagrant-persistent-storage (0.0.42)

        vagrant-share (1.1.9)

    Vagrant box list:

        centos/7  (virtualbox, 1809.01)

Infrastructure
--------------------------------
3 master nodes.

    master-one (Bastion node)

    master-two

    master-three & CNS Node

1 infra node.

    infra-one & CNS Node

1 app node.

    app-one & CNS Node

1 lb (HA proxy) node

    lb-one

CNS (Container Native Storage) as Storage solution.


![alt text](https://github.com/felix-centenera/OKD3.9_CentOS7.5/blob/master/img/Infraestruture.png)


Details
--------
User Virtual Machine:

  user: root

  password: vagrant

  user: vagrant

  password: vagrant

Openshift admin user:

  user: admin

  password: r3dh4t1!


Download the project
-----------------------------------------
```
git clone  https://github.com/felix-centenera/OKD3.9_CentOS7.5.git
```
Generate VirtualBox Machines with Vagrant
-----------------------------------------
```
cd OKD3.9_CentOS7.5/vagrant/

vagrant up
```
Login in the bastion
-----------------------------------------
```
vagrant ssh master-one
```
Prepare the bastion node
-----------------------------------------
```
su root

ansible-playbook -i /root/ansible/inventories/bastion /root/ansible/playbooks/bastion.yml
```

Prepare the rest of the nodes for OKD 3.9
-----------------------------------------
```
ansible-playbook -i /root/ansible/inventories/ocp /root/ansible/playbooks/preparation.yml
```
Check prerequisites of the nodes for OKD 3.9
--------------------------------------------
```
ansible-playbook -i /root/ansible/inventories/ocp  /root/release-3.9/playbooks/prerequisites.yml
```
Install OKD 3.9
--------------------------------------------
```
ansible-playbook -i /root/ansible/inventories/ocp /root/release-3.9/playbooks/deploy_cluster.yml
```

Post installation OKD 3.9
-----------------------------------------

```
ansible-playbook -i /root/ansible/inventories/ocp /root/ansible/playbooks/postinstallation.yml
```

Prepare OKD 3.9
-----------------------------------------
```
oc login -u system:admin -n default

oc adm policy add-cluster-role-to-user cluster-admin admin

oc patch storageclass glusterfs-storage -p '{"metadata": {"annotations": {"storageclass.kubernetes.io/is-default-class": "true"}}}'
```

Start using OKD 3.9
-----------------------------------------
https://console-ocp.192.168.33.7.xip.io:8443/console/project/

user: admin

password: r3dh4t1!
