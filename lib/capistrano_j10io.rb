if defined?(Capistrano::Configuration) && Capistrano::Configuration.instance
  Capistrano::Configuration.instance(:must_exist).load do
    set :rails_root, Dir.pwd
    require 'bundler/capistrano'        if File.exists?(File.join(fetch(:rails_root), 'Gemfile'))

    # Load base defaults unless disabled.
    if fetch(:base_defaults, true)
      load File.join(File.dirname(__FILE__), "capistrano_j10io/recipes/base.rb")
    end
    
  end
end

