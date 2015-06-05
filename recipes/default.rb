package 'autossh'

user_string = node['dev-reverse-tunnel']['user'] ? "#{node['dev-reverse-tunnel']['user']}@" : ''
identity_file_string = node['dev-reverse-tunnel']['identity-file'] ? " -i #{node['dev-reverse-tunnel']['identity-file']}" : ''
port_string = node['dev-reverse-tunnel']['port'] ? " -p #{node['dev-reverse-tunnel']['port']}" : ''
ssh_connection_string = "#{user_string}#{node['dev-reverse-tunnel']['host']}#{identity_file_string}#{port_string}"

# that checks both that the SSH creds are valid and that the reverse port is
# is available
execute "ssh #{ssh_connection_string} '! nc -z localhost #{node['dev-reverse-tunnel']['remote-port']}'"

runit_service 'dev-reverse-tunnel' do
  default_logger true
  options({ssh_connection_string: ssh_connection_string})
end
