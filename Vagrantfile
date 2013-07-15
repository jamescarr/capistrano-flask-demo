# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "capdemo"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"

  config.vm.define :appserver do |node_config|

    config.vm.provider :virtualbox do |vb|
      node_config.vm.hostname = 'appserver'
      node_config.vm.network :private_network, ip: '172.16.32.10'

      # Use VBoxManage to customize the VM. For example to change memory:
      vb.customize ["modifyvm", :id, "--memory", "256"]
    end
  end

  config.vm.define :guest do |node_config|

    config.vm.provider :virtualbox do |vb|
      node_config.vm.hostname = "#{node[:hostname]}"
      node_config.vm.network :private_network, ip: '172.16.32.11'

      # Use VBoxManage to customize the VM. For example to change memory:
      vb.customize ["modifyvm", :id, "--memory", "256"]
    end
  end

  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "provision/manifests"
     puppet.modules_path = "provision/modules"
     puppet.manifest_file  = "site.pp"
  end
end
