#
# Cookbook Name:: current_project
# Recipe:: run_rails
#
# Copyright 2017, Devico
#
# All rights reserved - Do Not Redistribute
#
rbenv_script "bundle_install" do
  user  'vagrant'
  cwd   '/vagrant'
  code %{bundle install}
end

rbenv_script "run_db_migrate" do
  user  'vagrant'
  cwd   '/vagrant'
  code %{rake RAILS_ENV=development db:migrate}
end

# rbenv_script "run_db_seed" do
#   user  'vagrant'
#   cwd   '/vagrant'
#   code %{rake RAILS_ENV=development db:seed}
# end

rbenv_script "run_rails" do
  user  'vagrant'
  cwd   '/vagrant'
  code %{rails s -b 0.0.0.0 --daemon}
end
