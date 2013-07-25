namespace :freshinstall do
  desc "Install the latest relase of Node.js"
  task :nodejs, roles: :app do
    add_apt_repository 'ppa:chris-lea/node.js'
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install nodejs"
  end
  after "deploy:install", "freshinstall:nodejs"
end