set :application, "testapp"
set :repository,  "git://github.com/sshristov/testapp.git"
 
set :user, :deployer
 
set :deploy_to, "/home/deployer/apps/testapp"
 
set :use_sudo, false
 
set :scm, :git
 
role :web, "10.0.11.14"                          # Your HTTP server, Apache/etc
role :app, "10.0.11.14"                          # This may be the same as your `Web` server
role :db,  "10.0.11.14", :primary => true # This is where Rails migrations will run
role :db,  "10.0.11.14"
 
default_run_options[:pty] = true
 
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 
   desc "Installs required gems"
   task :gems, :roles => :app do
     run "cd #{current_path} && sudo rake gems:install RAILS_ENV=production"
   end
   after "deploy:setup", "deploy:gems"  
 
   before "deploy", "deploy:web:disable"
   after "deploy", "deploy:web:enable"
end