# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure("2") do |config|
  config.vm.define "control" do |control|
    control.vm.box = "ubuntu/trusty64"
    control.vm.hostname = 'control'
    control.vm.box = "ubuntu/trusty64"

    control.vm.network :private_network, ip: "192.168.35.1"

    control.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "control"]
    end
  end

  config.vm.define "web1" do |web1|
    web1.vm.box = "ubuntu/trusty64"
    web1.vm.hostname = 'web1'
    web1.vm.box = "ubuntu/trusty64"

    web1.vm.network :private_network, ip: "192.168.35.101"

    web1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 256]
      v.customize ["modifyvm", :id, "--name", "web1"]
    end

    web1.ssh.private_key_path = ["keys/key", "~/.vagrant.d/insecure_private_key"]
    web1.ssh.insert_key = false
    web1.vm.provision "file", source: "keys/key.pub", destination: "~/.ssh/authorized_keys"
  end

  config.vm.define "web2" do |web2|
    web2.vm.box = "ubuntu/trusty64"
    web2.vm.hostname = 'web2'
    web2.vm.box = "ubuntu/trusty64"

    web2.vm.network :private_network, ip: "192.168.35.102"

    web2.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 256]
      v.customize ["modifyvm", :id, "--name", "web2"]
    end

    web2.ssh.private_key_path = ["keys/key", "~/.vagrant.d/insecure_private_key"]
    web2.ssh.insert_key = false
    web2.vm.provision "file", source: "keys/key.pub", destination: "~/.ssh/authorized_keys"
  end

  config.vm.define "app" do |app|
    app.vm.box = "ubuntu/trusty64"
    app.vm.hostname = 'app'
    app.vm.box = "ubuntu/trusty64"

    app.vm.network :private_network, ip: "192.168.35.103"

    app.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 256]
      v.customize ["modifyvm", :id, "--name", "app"]
    end

    app.ssh.private_key_path = ["keys/key", "~/.vagrant.d/insecure_private_key"]
    app.ssh.insert_key = false
    app.vm.provision "file", source: "keys/key.pub", destination: "~/.ssh/authorized_keys"
  end

  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/trusty64"
    db.vm.hostname = 'db'
    db.vm.box = "ubuntu/trusty64"

    db.vm.network :private_network, ip: "192.168.35.104"

    db.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 256]
      v.customize ["modifyvm", :id, "--name", "db"]
    end

    db.ssh.private_key_path = ["keys/key", "~/.vagrant.d/insecure_private_key"]
    db.ssh.insert_key = false
    db.vm.provision "file", source: "keys/key.pub", destination: "~/.ssh/authorized_keys"
  end
end