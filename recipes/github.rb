# Allows us to properly clone private repositories on GitHub

ruby_block "disable strict host key checking for github.com" do
  block do
    f = Chef::Util::FileEdit.new("/etc/ssh/ssh_config")
    f.insert_line_if_no_match(/github\.com/, <<-EOH

Host github.com
  StrictHostKeyChecking no
EOH
    )
    f.write_file
  end
end

ruby_block "make sudo honor ssh_auth_sock" do
  block do
    f = Chef::Util::FileEdit.new("/etc/sudoers")
    f.insert_line_if_no_match(/SSH_AUTH_SOCK/, <<-EOH

Defaults env_keep+=SSH_AUTH_SOCK
EOH
    )
    f.write_file
  end
end

# SSH agent forwarding is not behaving correctly on `vagrant up` commands.
# `vagrant provision` appears to set the SSH_AUTH_SOCK environment variable
# correctly. We would prefer to not dump our deployment key onto every single
# Vagrant instance.
#
# TODO - make SSH_AUTH_SOCK work ALL THE TIME!!
if ENV['SSH_AUTH_SOCK'].nil?
  Chef::Log.warn("SSH_AUTH_SOCK appears to be unset. Falling back to writing out deploy key instead (sadpanda).")

  include_recipe "users::opscode"

  cookbook_file "/home/opscode/.ssh/github" do
    source "opscode-github-sshkey-20130104"
    cookbook "opscode-github"
    owner "opscode"
    group "opscode"
    mode 0600
  end

  cookbook_file "/home/opscode/.ssh/config" do
    source "ssh_config"
    cookbook "opscode-github"
    owner "opscode"
    group "opscode"
    mode 0600
  end
else
  # Inspired by http://serverfault.com/a/442099/26589
  execute "open up access to SSH_AUTH_SOCK" do
    command <<-EOH
  chmod a+w $SSH_AUTH_SOCK
  chmod a+x $(dirname $SSH_AUTH_SOCK)
    EOH
    user "vagrant"
    environment(
      "SSH_AUTH_SOCK" => ENV['SSH_AUTH_SOCK']
    )
  end
end
