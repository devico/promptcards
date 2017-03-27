# Vagrant
# chef.add_recipe 'current_project::psql_db'

# easy_create_database
include_recipe "postgresql::server"
include_recipe "database::postgresql"

postgresql_connection_info = {
  :host     => '127.0.0.1',
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

postgresql_database_user 'promptcards' do
  connection postgresql_connection_info
  password '123654123'
  action :create
end

postgresql_database 'promptcards_development' do
  connection postgresql_connection_info
  encoding 'unicode'
  connection_limit '-1'
  owner 'promptcards'
  action :create
end

postgresql_database 'promptcards_test' do
  connection postgresql_connection_info
  encoding 'unicode'
  connection_limit '-1'
  owner 'promptcards'
  action :create
end

postgresql_database 'promptcards_production' do
  connection postgresql_connection_info
  encoding 'unicode'
  connection_limit '-1'
  owner 'promptcards'
  action :create
end
