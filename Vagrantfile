# -*- mode: ruby -*-
# vi: set ft=ruby :

$PROVISION_SCRIPT = <<SCRIPT
  echo 'StrictHostKeyChecking no' > ~/.ssh/config
  echo 'UserKnownHostsFile=/dev/null no' >> ~/.ssh/config
  apt-add-repository -y ppa:ansible/ansible
  apt-get update -q && apt-get install -y software-properties-common git ansible

  cd /home/vagrant/rails-app/cm/
  echo 'Install roles:'
  ansible-galaxy install -r requirements.yml --force
  echo 'Run asnible playbook locally:'
  PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=true ansible-playbook \
  dev.yml \
  -i inventory \
  -u vagrant \
  -c local
SCRIPT

Vagrant.configure(2) do |config|
  ram = 1024
  cpu = 2
  guest_port = 3000
  host_port = 3000
  dev_ip = '192.168.33.37'

  config.vm.provider 'virtualbox' do |v|
    v.memory = ram
    v.cpus = cpu
  end

  config.vm.network 'forwarded_port',  guest: guest_port, host: host_port

  # Development VM
  config.vm.define 'dev', primary: true do |dev|
    dev.vm.box = 'ubuntu/trusty64'
    dev.vm.hostname = 'rails-app'
    dev.vm.network 'private_network', ip: dev_ip
    dev.ssh.forward_agent = true
    dev.vm.synced_folder './', '/vagrant', disabled: true
    dev.vm.synced_folder './', '/home/vagrant/rails-app', owner: 'vagrant', group: 'vagrant'
    dev.vm.post_up_message = "Ready to development. Use \'vagrant ssh\' and \'bundle install\' after. \
    \nVirtual machine ip address: #{dev_ip} \
    \nYou can run rails on port: #{guest_port}. \
    \nSite will be aviable on http://#{dev_ip}:#{host_port}"

    dev.vm.provision 'shell', keep_color: true, inline: $PROVISION_SCRIPT
  end

  # Use vagrant-cachier to cache apt-get, gems and other stuff across machines
  config.cache.scope = :box if Vagrant.has_plugin?('vagrant-cachier')
end
