require 'capistrano-virtualenv'

server "172.16.32.10", :app, :primary => true

set :application,             "capistrano-flask-demo"
set :scm,                     "git"
set :repository,              "git@github.com:jamescarr/#{application}.git"
set :user,                    "deploy"
set :branch, 'master'

set :deploy_to,               "/usr/srv/#{application}"
set :deploy_via,              :remote_cache
ssh_options[:forward_agent] = true
set :use_sudo,                false
set :activate,                "#{virtualenv}/bin/activate"

namespace :supervisor do
  task :restart do
    sudo "supervisorctl restart #{application}"
  end
end


# Hooks
after "deploy:create_symlink", "supervisor:restart", "deploy:cleanup"
