Gem::Specification.new do |s|
  s.name        = "capistrano_j10io"
  s.version     = "0.0.1"
  s.summary     = "j10io's Capistrano Recipes"
  s.description = "Recipes for deploying a rails app to a close-to-fresh Ubuntu install. Can deploy NGINX, Postgres, Unicorn, rbenv and more."
  s.authors     = ["Jeremy Tennant"]
  s.files       = [
    "lib/capistrano_j10io.rb", 
    "lib/capistrano_j10io/recipes/base.rb",
    "lib/capistrano_j10io/recipes/helper.rb",
    "lib/capistrano_j10io/recipes/nginx.rb",
    "lib/capistrano_j10io/recipes/nodejs.rb",
    "lib/capistrano_j10io/recipes/postgresql.rb",
    "lib/capistrano_j10io/recipes/rbenv.rb",
    "lib/capistrano_j10io/recipes/unicorn.rb",
    "lib/capistrano_j10io/recipes/env_vars.rb"
  ]
  s.homepage    = "http://github.com/j10io/capistrano_j10io"

  s.add_dependency('capistrano',        ">= 2.14.0")
end
