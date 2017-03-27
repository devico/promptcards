#
# Cookbook Name:: current_project
# Recipe:: default
#
# Copyright 2017, Devico
#
# All rights reserved - Do Not Redistribute
#
include_recipe "postgresql::server"
include_recipe "database::postgresql"
