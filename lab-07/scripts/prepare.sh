#!/bin/bash

# Update System
sudo yum -y update
# Install EPEL repository.
sudo yum -y install epel-release
# Install Ansible.
sudo yum -y install ansible --enablerepo=epel