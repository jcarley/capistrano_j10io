load File.join(File.dirname(__FILE__), "helper.rb")
load File.join(File.dirname(__FILE__), "nginx.rb")
load File.join(File.dirname(__FILE__), "nodejs.rb")
load File.join(File.dirname(__FILE__), "postgresql.rb")
load File.join(File.dirname(__FILE__), "unicorn.rb")
load File.join(File.dirname(__FILE__), "rbenv.rb")
load File.join(File.dirname(__FILE__), "env_vars.rb")

set_default :application,  "appname"
set_default :git_user,     "gituser"
set_default :base_domain,  "example.com"
set_default :user,        'deployer'
set_default :deploy_to,    "/home/#{user}/apps/#{application}"
set_default :branch,      "master"
set_default :ruby_version, "2.0.0-p247"

set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:#{git_user}/#{application}.git"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

default_run_options[:pty] = true
