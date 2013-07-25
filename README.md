# capistrano_j10io
A collection of Jeremy (j10io's) capistrano recipes for Ubuntu 12.04. They can install NGINX, Postgresql, rbenv, nodejs.

## Adding to your rails project

The easiest way to install, is to add the followinc to your `Gemfile`:

```ruby
gem 'capistrano_j10io'
gem "capistrano"
```

Then, install it on the command line:

```
$ bundle install
```

Capify your project

```
$ cap .
```

Overwrite the default config/deploy.rb with the following, but ensure you modify the variables to meet your projects needs :)

```ruby
set :application,   "example"
set :git_user,      "example_github_user"
set :base_domain,   "example.com"
set :user,          "deployer"
set :deploy_to,     "/home/#{user}/apps/#{application}"
set :branch,        "master"
set :is_https?,     false

role :app,  '111.222.111.222'
role :web,  '111.222.111.222'
role :db,   '111.222.111.222', :primary => true

#Uncomment for carrierwave gem, which uploads to public/uploads (don't want to overwrite of uploads on each deployment)
#set :shared_children, shared_children + %w{public/uploads}

# Uncomment to include path to SSL, don't forget to chown root and chmod 400
# You'll need to manually place your certificate files on the server - this doesn't yet do this for you I'm afraid.
#set :ssl_cert_path, "/home/#{user}/apps/#{application}/cert.crt"
#set :ssl_key_path, "/home/#{user}/apps/#{application}/cert.key"

require 'capistrano_j10io'
```

## Ubuntu Setup.
Unfortunately this doesn't do **everything** for you, you'll need to/should do a few things on your ubuntu 12.04 server first.

1. Set your timezone `sudo dpkg-reconfigure tzdata`
2. Set your hostname, `sudo nano /etc/hosts`
3. Create a 'deployer' account `sudo adduser deployer --ingroup sudo`
4. Login as deployer `su deployer` and then ssh to github `ssh git@github.com` it will return "Permission denied (publickey)." - this is expected. You do this to ensure you don't get an error later on when you go to deploy your code from github.


## A fresh software install
With your (almost)blank ubuntu server ready for deployment (i.e. with the configuration noted above), running the following code will update Ubuntu, Upgrade Ubuntu, Install nginx, postgres, nodejs, rbenv, python-software-properties, software-properties-common (needed by apt-get) and ufw.

```
$ cap deploy:install
```

## Things to consider after deployment
1. [UFW](https://help.ubuntu.com/community/UFW) is installed as part of the cap deploy:install command, but it is not enabled, and there are no default rules created. Consider enabling.
2. Setting up automatic login using your SSH key

## When you're ready to deploy your app
1. Commit to github
2. `$ cap deploy:install` # as above
3. `$ cap deploy:setup` # creates database and directory structure
4. `$ cap deploy:cold` # deploys your code, does a migration, does a bundle install

## Capistrano Tasks included
To see all the capistrano tasks included:
```
$ cap -T
```

## Worth Noting / Assumptions
* In your `config/secret_token.rb` you should set the secret token to `ENV['APPLICATiON_SECRET_TOKEN']`
* `config/database.yml` is created on the fly with a password of your choosing.
* Assumes your primary domain will be at www.somedomain.com
* Assumes you want redirects from somedomain.com to www.somedomain.com

## Credits
Much of this based on the work of [Railscast #337](http://railscasts.com/episodes/337-capistrano-recipes). As always, amazing work by [@rbates](https://twitter.com/rbates)

## Contributing
The purpose of this gem is to make my own life easier through keeping my common capistrano recipes in a gem, I sincerely hope that you may benefit from it also. With that in mind, all pull requests will absolutely be considered and met with friendly discourse, however, as this project is for my own needs, you might consider forking the project for your own needs if you need to add new functionality as opposed to fix any bugs here.