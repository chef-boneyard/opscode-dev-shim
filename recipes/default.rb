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

# act like preprod
node.set[:app_environment] = "rs-preprod"

# Erlang-related
# TODO move these to opscode-erlang wrapper cookbook
node.set[:erlang_version] = "erlang_R15B01"
node.set[:rebar_version] = "2.0.0"

# DB-related
# TODO move these to opscode-database wrapper cookbook
node.set[:opscode][:database][:type] = "mysql"

# We notify the rsyslog all over our coookbooks. Declaring this resource
# ensures there is always a service to notify.
service "rsyslog" do
  supports :status => true, :restart => true
  action :nothing
end

# pretty much does what it says; most import thing is ensuring `apt-get update`
# has been run.
include_recipe "platform-specific"

# cookbooks that require the following should explicitly depend on them
# include_recipe "git"
include_recipe "perl"

# not a good way to get around the following dependencies
include_recipe "munin-stub::stub"

# Ensure we can pull from private GitHub repos
include_recipe "opscode-dev-shim::github"
