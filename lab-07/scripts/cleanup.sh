#!/bin/bash

# Remove Ansible.
sudo yum -y remove ansible

# Clean up temporary files and directories
sudo rm -rf /tmp/*