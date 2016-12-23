#!/bin/sh
sudo sed -i 's/#host_key_checking/host_key_checking/g' /etc/ansible/ansible.cfg