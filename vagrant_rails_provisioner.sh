#!/usr/bin/env bash

# A Centos 7.0 install aimed for Ruby on Rails development

# This box start with a basic Centos 7.0
# And it adds the following packages aimed for rails development

# - rvm
# - ruby 2.2.5 
# - rails 5.0.1
# - Git 1.9.1
# - Postgresql 9.3

# enable console colors
sed -i '1iforce_color_prompt=yes' ~/.bashrc

# disable docs during gem install
touch /home/vagrant/.gemrc
echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc

# essentials
sudo yum -y update

# setup RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
echo 'source ~/.profile' >> /home/vagrant/.bash_profile
source /home/vagrant/.rvm/scripts/rvm

# Install ruby 2.2.5 and rails 5.0.1
rvm requirements
rvm install 2.2.5
rvm use 2.2.5 --default
rvm rubygems current
gem install bundler
gem install rails -v 5.0.1

#Git
sudo yum install git

#Node.js
sudo yum install -y epel-release
sudo yum install -y nodejs

# Postgres
sudo yum install -y https://download.postgresql.org/pub/repos/yum/9.3/redhat/rhel-7-x86_64/pgdg-centos93-9.3-3.noarch.rpm
sudo yum install -y postgresql93 postgresql93-devel postgresql93-server postgresql93-contrib postgresql-libs postgresql-devel
sudo systemctl enable postgresql-9.3
sudo /usr/pgsql-9.3/bin/postgresql93-setup initdb
sudo systemctl start postgresql-9.3

# app specifics
cd /vagrant
bundle install
sudo -u postgres psql -c "CREATE USER promptcards WITH PASSWORD '123654123';"
sudo -u postgres psql -c "CREATE DATABASE promptcards_development OWNER promptcards;"
sudo -u postgres psql -c "CREATE DATABASE promptcards_test OWNER promptcards;"
sudo -u postgres psql -c "CREATE DATABASE promptcards_production OWNER promptcards;"
sudo -u postgres psql -c "ALTER USER promptcards WITH SUPERUSER CREATEROLE CREATEDB REPLICATION;"
#cp -R config/database.sample.yml config/database.yml
rake db:create
rake db:migrate

# cleanup
#sudo yum clean
