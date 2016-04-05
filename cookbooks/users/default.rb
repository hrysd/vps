require 'itamae/plugin/resource/authorized_keys'
require 'unix_crypt'

node['users'].each do |user|
  username   = user['name']
  group_name = user['group']

  user username do
    password UnixCrypt::SHA512.build(ENV['USER_PASSWORD'], ENV['PASSWORD_SALT'])
    shell '/bin/bash'
  end

  authorized_keys username do
    github username
  end

  group group_name

  # not_if ?
  execute "add #{username} to group" do
    command "gpasswd -a #{username} #{group_name}"
  end
end

remote_file '/etc/sudoers.d/developers' do
  mode   '0440'
  owner  'root'
  group  'root'
end
