# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<-SCRIPT
if [ -x "$(command -v apt-get)" ]; then
  apt-get update
  apt-get install -y python
elif [ -x "$(command -v yum)" ]; then
  // yum install ...
else
  // printenv
fi
echo "done"
SCRIPT

Vagrant.configure("2") do |config|
  config.vbguest.no_remote = true
  config.vbguest.auto_update = false

  config.vm.define 'xenial' do |instance|
    instance.vm.box = 'ubuntu/xenial64'
  end

  config.vm.define 'trusty' do |instance|
    instance.vm.box = 'ubuntu/trusty64'
  end

  # install dependencies
  config.vm.provision "shell", inline: $script

  # View the documentation for the provider you're using for more
  # information on available options.
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "tests/main.yml"
    ansible.verbose = 'vv'
    ansible.sudo = true
  end
end
