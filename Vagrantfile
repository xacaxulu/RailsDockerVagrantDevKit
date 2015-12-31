# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "phusion/ubuntu-14.04-amd64"
  config.vm.synced_folder "./", "/app", type: 'nfs'
  config.vm.network "forwarded_port", guest: 3000, host: 1234
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "6000"
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo docker 2> /dev/null
    if [ $? -eq 0 ]
      then
        echo "Docker exists, skipping..."
        exit 0
      else
        sudo curl -sSL https://get.docker.com/ | sh
        sudo curl -L https://github.com/docker/compose/releases/download/1.4.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
    fi    
  SHELL

  config.vm.provision "chef_apply" do |chef|
    chef.recipe = <<-RECIPE

      package 'awscli'
      
      group 'docker'

      bash 'docker_sudoer' do
        code 'sudo usermod -aG docker vagrant'
      end

      service 'docker' do
        action :start
      end
    RECIPE
  end
end
