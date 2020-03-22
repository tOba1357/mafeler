# README
## links
production: https://heeeealthy.com
## How to deploy
### Infrastructure construction
aws
- EC2(nginx + puma + rails)
- ELB
- route53

### set up EC2 instance
1. update
```bash
sudo yum update
```
2. install dependencies
``` bash
sudo yum install -y git gcc openssl-devel readline-devel zlib-devel postgresql-devel
``` 
3. install nodejs and yarn
```bash
# install noede js
curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
sudo yum -y install nodejs
# install yarn
curl -o- -L https://yarnpkg.com/install.sh | bash
source ~/.bashrc
```
4. install rbenv & ruby 2.5.1
```bash
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

rbenv install 2.5.1
rbenv global 2.5.1
rbenv rehash
gem install bundler
```
5. set env
```.bashrc
export DATABASE_HOST=
export DATABASE_PORT=
export DATABASE_USER=
export DATABASE_PASSWORD=
export DATABASE_NAME=
```
6. create deploy key
7. set nginx
TODO: write how to install it
```bash
sudo mkdir /etc/nginx/sites-available
sudo mkdir /etc/nginx/sites-enabled
sudo mkdir /var/www
touch /vra/www/404.html
touch /var/www/50x.html
touch chown ec2-user:ec2-user /var/www/*
```
edit nginx config
```nginx.conf
user ec2-user;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;
    server_tokens off;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;
    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;

    server {
        listen       80  default_server;
        server_name  _;
        return       444;
    }
}

```
upload puma.rb nginx_conf
```bash
bundle exec cap production puma:nginx_config
```

**note**  
When EC2 instance is low memory and do asset precompile, out of memory error occur.  
The solution is to set up swap memory.  
Reference https://qiita.com/na0AaooQ/items/278a11ed905995bd16af.

### deploy rails app
```bash
bundle exec cap production deploy
```
