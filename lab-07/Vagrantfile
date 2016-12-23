# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.define "yollando" do |yollando|
    yollando.vm.box = "puppetlabs/centos-7.0-64-nocm"
  end

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = "2"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provision/site.yml"
    ansible.groups = {
      "data-tier" => ["yollando"],
      "web-tier" => ["yollando"],
      "application-tier" => ["yollando"],
    }
    ansible.extra_vars = {
      env_name: "dev",
    }
  end

  config.vm.provision "ansible" do |test|
    test.playbook = "test/site.yml"
    test.groups = {
      "web-tier" => ["yollando"],
      "application-tier" => ["yollando"],
    }
  end

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 8090, host: 8090

end
