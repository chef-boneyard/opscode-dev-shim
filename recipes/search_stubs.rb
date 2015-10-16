#
# Cookbook Name:: opscode-dev-shim
# Recipe:: search_stubs
#
# Copyright (C) 2013 Opscode, Inc.
#
# All rights reserved - Do Not Redistribute
#

# Data Bag: users
# Data Bag Item: opscode
#
# The `opscode` is required in a number of cookbooks/recipes
#
stub_search(:users, 'groups:opscode').to_return([
  {
    "comment" => "Opscode deploy user",
    "groups" => [
      "opscode"
    ],
    "ssh_keys" => [
    ],
    "id" => "opscode",
    "uid" => 5049,
    "shell" => "/bin/bash"
  }
])

# Data Bag: webui-public-keys
# Data Bag Item: *
#
# We distribute webui public keys using this data bag item
#
stub_search("webui-public-keys", '*:*').to_return([
  {
    "name" => "data_bag_item_webui-public-keys_webui_key_20120418220704",
    "json_class" => "Chef::DataBagItem",
    "chef_type" => "data_bag_item",
    "data_bag" => "webui-public-keys",
    "raw_data" => {
      "id" => "webui_key_20120418220704",
      "public_key" => "-----BEGIN RSA PUBLIC KEY-----\nMIIBCgKCAQEA69GUdxNfjc4srWM/VDkpUv6mUhkgDHXGAr68kpFg16faFvrASkmL\ntUIWwKnCG8Rn+VsWV1DOM2R4oimTNQjtQZadGoc64huGA6PmXlZTqImUTgZDKpPl\n/LpumvkZvQDirVjgkZ17e56KOkgv+fyZz6wF/VPN2XMJQg7sBtjKPz3nOw71qsEu\nOcbLtyVEpAtj/TVltSDtg6+4+mqZLA2JA13BAPCUOZYdqZvZWC7BSExr+EL/Dvhh\n2sYBZxA8ZQPixhkz6ZBpY0+PEYufkbNCT0aw1VpTEwcdXvbOjZyhw3BZ+Mlp40sS\n8n0dhcafWhlsvH7KZDi3CDMtQebyH6zRkQIDAQAB\n-----END RSA PUBLIC KEY-----\n"
    }
  }
])

# Nagios nodes
stub_search("node", "role:monitoring-nagios").to_return([node_stub("nagios-stub-host")])

# This is what is currently used for nagios search - leaving previous query aboe in case
# something else uses it
stub_search("node",
            "( role:monitoring-nagios OR role:seabuild-monitoring ) AND chef_environment:dev").to_return([node_stub("nagios-stub-host")])

# This is the search currently used by the opscode-bifrost cookbook
stub_search(:node, "role:monitoring-munin* OR role:monitoring-nagios OR role:seabuild-munin").to_return([node_stub("nagios-stub-host")])
