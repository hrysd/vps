%w(
  build-essential
  libpcre3
  libpcre3-dev
  zlib1g
  zlib1g-dev
  openssl
  libssl-dev
).each do |dependency|
  package dependency
end

user 'nginx' do
  shell '/bin/false'
end

group 'nginx'

execute "add nginx to group" do
  command "gpasswd -a nginx nginx"
end

nginx_version = node['nginx']['version']

execute "nginx-build -d /usr/local/src -v #{nginx_version}" do
  not_if 'test -d /usr/local/nginx'
end

execute 'make install' do
  cwd "/usr/local/src/nginx/#{nginx_version}/nginx-#{nginx_version}"
end

remote_file '/lib/systemd/system/nginx.service' do
  mode  '0644'
  owner 'root'
  group 'root'
end

remote_file '/usr/local/nginx/conf/nginx.conf' do
  mode  '0644'
  owner 'root'
end

service 'nginx' do
  action [:reload, :enable, :start]
end
