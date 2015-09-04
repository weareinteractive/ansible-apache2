#!/bin/bash


echo '............'
echo $CI_HOME
echo $ROLE_NAME


PWD=$(pwd)
ROLE_NAME=franklinkim.apache2

ls -la /etc

ls -la /etc/ansible

echo 'creating role symlink'
ln -s $(dirname $PWD) /etc/ansible/roles/$ROLE_NAME

echo 'running playbook'
ansible-playbook -vvvv -i 'localhost,' -c local $PWD/test/playbook.yml
