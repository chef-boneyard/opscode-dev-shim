# opscode-dev-shim cookbook

This cookbook is meant to be a compatibility layer for running our preprod/prod coobooks in
the comforting isolation of Vagrant! This means a quicker, *safer* feedback loop
while hacking on new or existing cookbooks.

## License

All files in the repository are licensed under the Apache 2.0 license. If any
file is missing the License header it should assume the following is attached;

```
Copyright 2014 Chef Software Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

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
