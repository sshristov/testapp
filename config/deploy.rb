# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'testapp'
set :repo_url, 'git@github.com:sshristov/testapp.git'

set :deploy_to, "/home/deployer/apps/testapp"

set :pty, true

set :format, :pretty

role :web, "10.0.11.14"                          # Your HTTP server, Apache/etc
role :app, "10.0.11.14"                          # This may be the same as your `Web` server
role :db,  "10.0.11.14", :primary => true # This is where Rails migrations will run
role :db,  "10.0.11.14"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  
  desc 'Restart application'

  task :restart do
     on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      #execute :touch, 'tmp/restart.txt'
      execute :touch, release_path.join('/tmp/testapp/restart.txt')
      within release_path do
      execute :rake, 'db:migrate'
      execute :rails, 'server', '-d'
      #execute :kill, '-9', 'cat 'tmp/pids/server.pid'
      #run "kill -9 $(cat tmp/pids/server.pid)"
    #execute :kill, 'echo $(cat tmp/pids/server.pid)'
     # execute :fuser, '-k 3000/tcp' 
     #execute :kill '-9', $(lsof -i:3000 -t)
    end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
       #Here we can do anything such as:
         within release_path do
         execute :rake, 'db:migrate' #'rails s'
	 #execute :rails, 'rails s'
	 execute :rails, 'server', '-d'
	 #execute:fuser, '-k 3000/tcp'

       end
    end
  end
  
end

