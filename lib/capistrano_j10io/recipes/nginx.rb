namespace :freshinstall do
  desc "Install latest stable release of nginx"
  task :nginx, roles: :web do
    add_apt_repository 'ppa:nginx/stable'
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install nginx"
  end
  after "deploy:install", "freshinstall:nginx"
end

namespace :nginx do
  desc "Setup nginx configuration for this application"
  task :setup, roles: :web do
    template nginx_template, "/tmp/nginx_conf"
    run "#{sudo} mv /tmp/nginx_conf /etc/nginx/sites-enabled/#{application}"
    run "#{sudo} rm -f /etc/nginx/sites-enabled/default"
    restart
  end
  after "deploy:setup", "nginx:setup"
  
  %w[start stop restart].each do |command|
    desc "#{command} nginx"
    task command, roles: :web do
      run "#{sudo} service nginx #{command}"
    end
  end
end