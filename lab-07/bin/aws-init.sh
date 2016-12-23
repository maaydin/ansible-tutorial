#!/bin/bash
#export AWS_ACCESS_KEY_ID=
#export AWS_SECRET_ACCESS_KEY=
usage(){
   echo "Usage: $0 <image-id>"
   exit 1
}
[[ $# -ne 1 ]] && usage

ansible-playbook provision/aws-init.yml --extra-vars "env_name=aws image_id=$1"
