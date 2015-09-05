#!/bin/bash

PWD=$(pwd)
ROLE_NAME=franklinkim.apache2

echo 'creating role symlink'
ln -s $(dirname $PWD) /usr/share/ansible/roles/$ROLE_NAME

echo 'running playbook'
ansible-playbook -vvvv -i 'localhost,' -c local $PWD/tests/playbook.yml
