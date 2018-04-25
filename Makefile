PWD=$(shell pwd)
ROLE_NAME=franklinkim.apache2
ROLE_PATH=/etc/ansible/roles/$(ROLE_NAME)
TEST_VERSION=ansible --version
TEST_DEPS=ansible-galaxy install weareinteractive.apt franklinkim.openssl franklinkim.htpasswd
TEST_SYNTAX=ansible-playbook -v -i 'localhost,' -c local $(ROLE_PATH)/tests/main.yml --syntax-check
TEST_PLAYBOOK=ansible-playbook -vvvv -i 'localhost,' -c local $(ROLE_PATH)/tests/main.yml
TEST_CMD=$(TEST_DEPS); $(TEST_VERSION); $(TEST_SYNTAX); $(TEST_PLAYBOOK)

test_ubuntu16.10: dist=ubuntu-16.10
test_ubuntu16.10: test

test_ubuntu16.04: dist=ubuntu-16.04
test_ubuntu16.04: test

test_ubuntu14.04: dist=ubuntu-14.04
test_ubuntu14.04: test

test_debian9: dist=debian-9
test_debian9: test

test_debian8: dist=debian-8
test_debian8: test

test:
	docker run -it --rm -v $(PWD):$(ROLE_PATH) ansiblecheck/ansiblecheck:$(dist) /bin/bash -c "$(TEST_CMD)"
