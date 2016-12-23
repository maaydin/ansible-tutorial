#!/bin/sh
eval `ssh-agent`
ssh-add /vagrant/keys/key

ansible -m apt -a "name=nginx state=present update_cache=yes" webservers --become
ansible -m service -a "name=nginx state=started enabled=yes" webservers --become
ansible -m file -a "path=/usr/share/nginx/html state=directory" webservers --become
ansible -m copy -a "src=/vagrant/lab-03/index.html dest=/usr/share/nginx/html/index.html" webservers --become