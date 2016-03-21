require 'itamae/plugin/resource/authorized_keys'
require 'unix_crypt'

node['users'].each do |username|
  user username do
    password UnixCrypt::SHA512.build(ENV['USER_PASSWORD'], ENV['PASSWORD_SALT'])
  end

  authorized_keys username do
    github username
  end

  group 'developers'

  # not_if ?
  execute "add #{username} to group" do
    command "gpasswd -a #{username} developers"
  end
end

remote_file '/etc/sudoers.d/developers' do
  mode   '440'
  owner  'root'
  group  'root'
end
