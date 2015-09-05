#!/bin/bash

PWD=$(pwd)
ROLE_NAME=franklinkim.apache2

ls -la /usr/share

ls -la /usr/share/ansible

echo 'creating role symlink'
ln -s $(dirname $PWD) /usr/share/ansible/roles/$ROLE_NAME

ls -la /usr/share/ansible/roles

cat /etc/ansible/ansible.cfg

echo 'running playbook'
ansible-playbook -vvvv -i 'localhost,' -c local $PWD/tests/playbook.yml
