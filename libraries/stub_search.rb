
if Chef::Config[:solo]

  begin
    require 'searchef'
  rescue LoadError
    run_context = Chef::RunContext.new(Chef::Node.new, {}, Chef::EventDispatch::Dispatcher.new)
    # This is a workaround - until we either are able to  update chef json dependency
    # or get a PR in to lock fauxhai to 0.11 of httparty.
    #
    # httparty is a requirement of fauxhai via searchef. Later
    # versions of it (0.12.0+) require json gem 1.8; this will fail
    # as a chef_gem because embedded chef accepts only 1.4-1.7.
    # Since fauxhai doesn't lock in a version, if we ensure the older
    # version of httparty is present before pulling it in, chef_gem
    # won't cause  0.12 or later to get pulled in.
    httparty_gem = Chef::Resource::ChefGem.new("httparty", run_context)
    httparty_gem.version "=0.11.0"
    httparty_gem.run_action(:install)
    Chef::Resource::ChefGem.new("searchef", run_context).run_action(:install)
    require 'searchef'
  end

  # stop signing key loading
  # https://github.com/opscode/chef/commit/0d08d6efa1d8b51381b914e71bbd87b01225f3f7
  # https://github.com/opscode/chef/blob/master/lib/chef/rest.rb#L424-L425
  Chef::Config[:client_key] = nil

  class Chef
    class Recipe
      include Searchef::API
    end
  end

end
