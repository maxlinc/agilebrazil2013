# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/etc/puppet"
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path = ['modules', 'my_modules']
    puppet.manifest_file  = "site.pp"
  end

  config.vm.provision :shell, :inline => "facter --yaml > /vagrant/fixtures/facts/$HOSTNAME.yaml"

  config.vm.define :dev do |dev|
    dev.vm.box = "ubuntu_precise64"
    dev.vm.hostname = "blog-dev.example.com"
    dev.vm.box_url = "http://f.willianfernandes.com.br/vagrant-boxes/UbuntuServer12.04amd64.box"
    dev.vm.network :forwarded_port, guest: 80, host: 8080
  end

  config.vm.define :prod do |prod|
    prod.ssh.private_key_path = "~/.ssh/id_rsa"
    prod.vm.box = "dummy"
    prod.vm.provider :rackspace do |rs|
      rs.username = ENV['OS_USERNAME']
      rs.api_key  = ENV['OS_PASSWORD']
      rs.flavor   = /512MB/
      rs.image    = /Ubuntu/
      rs.public_key_path = "~/.ssh/id_rsa.pub"
    end
    prod.vm.hostname = "blog.example.com"
  end
end
