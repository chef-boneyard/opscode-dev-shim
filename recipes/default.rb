#
# Cookbook Name:: opscode-dev-shim
# Recipe:: default
#
# Copyright (C) 2013 Opscode, Inc.
#
# All rights reserved - Do Not Redistribute
#

# Set a dev_mode flag to 'true'. We key off of this attribute in some helpsers
# like OpscodeHelpers.dev_mode? (from the opscode_extensions cookbook)
node.set[:dev_mode] = true

# Recent modifications move to using the actual environment name in our platform cookbooks - however
# earlier versions of vagrant & chef-solo don't support setting that in the
# chef-solo config. Provide a sane default of 'dev' for both :app_environment attribute
# and the node's environment, if nothing has been provided.
node.set[:app_environment] = "dev" unless node[:app_environment]
node.chef_environment(node[:app_environment]) unless node.chef_environment != "_default"

# Erlang-related
# TODO move these to opscode-erlang wrapper cookbook
node.set[:erlang_version] = "erlang_R15B01"
node.set[:rebar_version] = "2.0.0"

# DB-related
# TODO move these to opscode-database wrapper cookbook
node.set[:opscode][:database][:type] = "mysql"

# Request stubbing of munin
node.set[:munin][:stub] = true

# We notify the rsyslog all over our coookbooks. Declaring this resource
# ensures there is always a service to notify.
service "rsyslog" do
  supports :status => true, :restart => true
  action :nothing
end

# Stub out searches with `searchef`
include_recipe "opscode-dev-shim::search_stubs"

# pretty much does what it says; most import thing is ensuring `apt-get update`
# has been run.
include_recipe "platform-specific"

# cookbooks that require the following should explicitly depend on them
# include_recipe "git"
include_recipe "perl"

# Ensure we can pull from private GitHub repos
include_recipe "opscode-dev-shim::github"
