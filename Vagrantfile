# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define :alpha do |config|
    config.vm.box = 'wheezy76'

    config.vm.network :forwarded_port, guest: 22, host: 2022, id: 'ssh'
    config.vm.network :forwarded_port, guest: 80, host: 2080, id: 'http'
    config.vm.network :private_network, ip: '192.168.33.10'
  end

  config.vm.box_url = 'https://dl.dropboxusercontent.com/u/17215310/wheezy76.box'
end
