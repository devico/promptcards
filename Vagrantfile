# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
REQUIRED_PLUGINS = %w(vagrant-vbguest vagrant-librarian-chef-nochef)

plugins_to_install = REQUIRED_PLUGINS.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing required plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting. Please read the Bike Index README."
  end
end

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "elastic/fedora-23-x86_64"

  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision :chef_solo do |chef|

    chef.version = "12.19.36"
    chef.cookbooks_path = ["cookbooks", "cookbooks_addons"]

    config.ssh.username = 'vagrant'
    config.ssh.password = 'vagrant'
    config.ssh.shell = "bash"
    config.ssh.insert_key = "false"

    chef.add_recipe 'apt'
    chef.add_recipe 'build-essential'
    chef.add_recipe 'ruby_build'
    chef.add_recipe 'ruby_rbenv::user'
    chef.add_recipe 'ruby_rbenv::user_install'
    chef.add_recipe 'postgresql::server'
    chef.add_recipe 'postgresql::client'
    chef.add_recipe 'postgresql::ruby'
    chef.add_recipe 'current_project::psql_db'
    chef.add_recipe 'nodejs'
    chef.add_recipe 'current_project::run_rails'
    chef.add_recipe 'git'

    chef.json = {
      rbenv: {
        user_installs: [{
          user: 'vagrant',
          rubies: ["2.2.5"],
          global: "2.2.5",
          gems: {
            "2.2.5" => [{ name: "bundler" }]
          }
        }]
      },
      postgresql: {
        pg_hba: [
          {type: 'local', db: 'all', user: 'postgres', addr: nil, method: 'trust'},
          {type: 'local', db: 'all', user: 'all', addr: nil, method: 'trust'},
          {type: 'host', db: 'all', user: 'all', addr: '127.0.0.1/32', method: 'trust'},
          {type: 'host', db: 'all', user: 'all', addr: '::1/128', method: 'trust' }
        ], 
        password: {
          postgres: ""
        },
        user: {
          name: 'vagrant',
          password: '',
          createdb: true,
          login: true
        }
      },
      "run_list": ["recipe[postgresql::server]"]
    }
  end

# $script = <<SCRIPT
# cd /vagrant
# sudo -u postgres psql -c "CREATE USER vagrant WITH PASSWORD '123654123';"
# sudo -u postgres psql -c "CREATE USER promptcards WITH PASSWORD '123654123';"
# sudo -u postgres psql -c "CREATE DATABASE promptcards_development OWNER promptcards;"
# sudo -u postgres psql -c "CREATE DATABASE promptcards_test OWNER promptcards;"
# sudo -u postgres psql -c "CREATE DATABASE promptcards_production OWNER promptcards;"
# sudo -u postgres psql -c "ALTER USER promptcards WITH SUPERUSER CREATEROLE CREATEDB REPLICATION;"
# sudo -u postgres psql -c "ALTER USER vagrant WITH SUPERUSER CREATEROLE CREATEDB REPLICATION;"
# SCRIPT

#   config.vm.provision :shell, :inline => $script, privileged: true

end
