# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'testapp'
set :repo_url, 'git@github.com:sshristov/testapp.git'

set :deploy_to, "/home/deployer/apps/testapp"

set :pty, true

set :format, :pretty





# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# rbenv
set :rbenv_type, :user
set :rbenv_ruby, '2.1.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
 
set :log_level, :info
 
# how many old releases do we want to keep, not much
set :keep_releases, 5
 
# files we want symlinking to specific entries in shared
set :linked_files, %w{config/database.yml config/application.yml config/secrets.yml}
 
# dirs we want symlinking to shared
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
 
set :pty, true
 
# which config files should be copied by deploy:setup_config
# see documentation in lib/capistrano/tasks/setup_config.cap
# for details of operations
set(:config_files, %w(
  application.yml
  database.yml
  
))



namespace :deploy do
after :finishing, 'deploy:cleanup'
after 'deploy:publishing'

end

