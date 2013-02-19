
if Chef::Config[:solo]

  begin
    require 'searchef'
  rescue LoadError
    run_context = Chef::RunContext.new(Chef::Node.new, {}, Chef::EventDispatch::Dispatcher.new)
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
