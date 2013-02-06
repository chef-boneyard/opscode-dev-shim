# opscode-dev-shim cookbook

This cookbook is meant to be a compatibility layer for running our preprod/prod coobooks in
the comforting isolation of Vagrant! This means a quicker, *safer* feedback loop
while hacking on new or existing cookbooks.

# Requirements

The only real requirement is a properly configured Berkshelf config file. At a minimum you
will need the following values so Berkshelf can talk to the preprod organization correclty:

```
% cat /Users/schisamo/.berkshelf/config.json
{
  "chef": {
    "chef_server_url": "https://opsmaster-api.opscode.us/organizations/preprod",
    "node_name": "schisamo",
    "client_key": "/Users/schisamo/.chef/schisamo-opsmaster.pem"
  }
}
```

# Usage

Ensure this cookbook is first in your runlist. You will want a `Vagrantfile` that looks
similar to:

```ruby
  config.vm.provision :chef_solo do |chef|
    chef.json = {}
    chef.data_bags_path = "../../data_bags"
    chef.roles_path = "../../roles"
    chef.run_list = [
      "recipe[opscode-dev-shim]",
      "recipe[opscode-erchef::default]"
    ]
  end
```

# Author

Author:: Seth Chisamore (<schisamo@opscode.com>)
