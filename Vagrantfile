# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  config.vm.box = "mybase"
  config.vbguest.auto_update = false
  config.ssh.insert_key = false

  # virtualbox specific config
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.cpus = 2
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.memory = 1024
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :machine
  end

  # This is where customizations to each box are applied.
  # This one is for provisioning JupyterHub.
  config.vm.define "jupyterhub" do |jupyterhub|
    # In addition to the NAT interface, add this private, host-only network
    # interface to enable communication w/ other VMs on the host w/ IP of
    # 192.168.33.x
    jupyterhub.vm.network "private_network", ip: "192.168.33.10"
    jupyterhub.vm.provider "virtualbox" do |vb|
      vb.name = "jupyterhub"
    end
    jupyterhub.vm.provision "shell", path: "jupyterhub/sbin/provision.sh"
  end

end
