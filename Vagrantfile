# Download and Install Oracle VirtualBox
# Download and Install Developer Hashicorp Vagrant
# Open Command Prompt
# Add the Ubuntu 20.04 (Focal) image to your box list:
# 1. Vagrant box add ubuntu/focal64
# 2. vagrant init ubuntu/focal64
# 3. vagrant plugin install vagrant-vbguest
# 4. vagrant destroy
# 5. vagrant up
# 6. vagrant ssh


# -*- mode: ruby -*-
# vi: set ft=ruby :

NUM_WORKERS = 4

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # Common settings
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end

  # Master node
  config.vm.define "master" do |master|
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "192.168.56.10"
  end

  # Worker nodes
  (1..NUM_WORKERS).each do |i|
    config.vm.define "worker#{i}" do |node|
      node.vm.hostname = "worker#{i}"
      node.vm.network "private_network", ip: "192.168.56.#{10 + i}"
    end
  end
end
