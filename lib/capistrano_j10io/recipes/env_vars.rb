namespace :env do
  desc "Add Environment Variables"
  task :setup, roles: :app do
    template "bashrc.erb", "/tmp/bashrc"
    run "cat /tmp/bashrc ~/.bashrc > ~/.bashrc.tmp"
    run "mv ~/.bashrc.tmp ~/.bashrc"
  end
  after "deploy:setup", "env:setup"
end