#!/bin/bash

ansible-playbook -vvvv -i 'localhost,' -c local test.yml
