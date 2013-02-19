name             "opscode-dev-shim"
maintainer       "Seth Chisamore"
maintainer_email "schisamo@opscode.com"
license          "All rights reserved"
description      "Installs/Configures opscode-dev-shim"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

depends "platform-specific"
depends "munin-stub"
depends "users"
depends "git"
depends "perl"
depends "opscode-github"
