file '/etc/ssh/sshd_config' do
 action :edit

  block do |content|
    content.gsub! /^Port\s.*/,                   "Port #{ENV['SSH_PORT']}"
    content.gsub! /^PermitRootLogin\s.*/,        'PermitRootLogin no'
    content.gsub! /^PasswordAuthentication\s.*/, 'PasswordAuthentication no'
  end
end

service 'sshd' do
  subscribes :restart, 'file[/etc/ssh/sshd_config]'
end
