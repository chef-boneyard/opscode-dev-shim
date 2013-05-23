name             "opscode-dev-shim"
maintainer       "Seth Chisamore"
maintainer_email "schisamo@opscode.com"
license          "All rights reserved"
description      "Installs/Configures opscode-dev-shim"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.3"

# internal cookbooks
depends "users", "~> 0.1.6"
depends "apt"
depends "platform-specific", "~> 0.0.1"
depends "opscode-github", "~> 0.7.0"
depends "git"
# This is the munin cookbook as found in opscode-platform-cookbooks
# with included stubbing abilities.
depends "munin", "~> 0.8.1"
depends "perl"
