#!/bin/bash

PWD=$(pwd)
ROLE_NAME=franklinkim.apache2

ln -s $(dirname $PWD) /etc/ansible/roles/$ROLE_NAME

ansible-playbook -vvvv -i 'localhost,' -c local $PWD/test/playbook.yml
