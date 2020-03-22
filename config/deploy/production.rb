set :rails_env, 'production'
server 'ec2-13-115-65-116.ap-northeast-1.compute.amazonaws.com', user: 'ec2-user', roles: %w{app db web}
ssh_key_path = ENV['SSH_KEY_PATH'] || '~/.ssh/my-ec2.pem'
set :ssh_options, {
 keys: [ssh_key_path],
 forward_agent: false,
}

set :nginx_server_name, 'heeeealthy.com'
