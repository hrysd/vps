%w(
  build-essential
  libpcre3
  libpcre3-dev
  zlib1g
  zlib1g-dev
  openssl
  libssl-dev
).each do |dependency|
  pacakge dependency
end

execute 'get nginx-build binary' do
  cwd '/tmp'

  command 'wget https://github.com/cubicdaiya/nginx-build/releases/download/v0.7.2/nginx-build-linux-amd64-0.7.2.tar.gz'

  not_if 'test -e /usr/local/bin/nginx-build'
end

execute 'tar zxvf nginx-build-linux-amd64-0.7.2.tar.gz' do
  cwd '/tmp'

  not_if 'test -e /usr/local/bin/nginx-build'
end

execute 'mv nginx-build /usr/local/bin' do
  cwd '/tmp'

  not_if 'test -e /usr/local/bin/nginx-build'
end

nginx_version = node['nginx']['version']

execute "nginx-build -d /usr/local/src -v #{nginx_version}"

execute 'make install' do
  cwd "/usr/local/src/nginx/#{nginx_version}/nginx-#{nginx_version}"
end

remote_file '/lib/systemd/system/nginx.service'

service 'nginx' do
  action [:enable, :start]
end
