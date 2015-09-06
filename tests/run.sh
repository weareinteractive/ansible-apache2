#!/bin/bash

PWD=$(pwd)
ROLE_NAME=franklinkim.apache2

echo 'installing dependencies'
ansible-galaxy install franklinkim.openssl
ansible-galaxy install franklinkim.htpasswd

echo 'creating role symlink'
ln -s $PWD /usr/share/ansible/roles/$ROLE_NAME

echo 'running playbook'
ansible-playbook -vvvv -i 'localhost,' -c local $PWD/tests/playbook.yml
