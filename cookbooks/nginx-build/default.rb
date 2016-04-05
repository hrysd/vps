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
