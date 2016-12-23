#!/bin/sh
eval `ssh-agent`
ssh-add /vagrant/keys/key

ansible -m ping web1
ansible -m ping app
ansible -m ping webservers
ansible -m ping dc
ansible -m shell -a 'ls -al' web1
ansible -m shell -a 'whoami' app
ansible -m shell -a 'ifconfig' webservers
ansible -m shell -a 'hostname' dc
ansible -m ping all
ansible -m ping web*
ansible -m ping 'appservers:dbservers'
ansible -m ping 'dc:!webservers'
ansible -m ping 'dc:&webservers'