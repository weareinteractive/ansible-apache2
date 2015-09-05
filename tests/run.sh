#!/bin/bash

PWD=$(pwd)
ROLE_NAME=franklinkim.apache2

echo 'creating role symlink'
ln -s $PWD /usr/share/ansible/roles/$ROLE_NAME

echo 'debug'
echo $PWD
ls -la /usr/share/ansible/roles/
ls -la /usr/share/ansible/roles/$ROLE_NAME/
ls -la /usr/share/ansible/roles/$ROLE_NAME/tasks

echo 'running playbook'
ansible-playbook -vvvv -i 'localhost,' -c local $PWD/tests/playbook.yml
