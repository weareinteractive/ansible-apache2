#!/bin/bash

PWD=$(pwd)
ROLE_NAME2=franklinkim.apache2

echo "--------------"
echo $ROLE_NAME

echo ansible --version

echo 'creating role symlink'
ln -s $PWD /usr/share/ansible/roles/$ROLE_NAME2

echo 'running playbook'
ansible-playbook -vvvv -i 'localhost,' -c local $PWD/tests/playbook.yml
