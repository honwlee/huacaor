require 'bundler/capistrano'
set :application, "huacaor"
set :domain, 'huacaor.com'
default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git://github.com/dream-hunter/huacaor.git"  # Your clone URL
set :scm, "git"
set :user, "hongwangli"  # The server's user for deploys
#set :scm_passphrase, ""  # The deploy user's password
set :rails_env, "production"
set :deploy_to, '/srv/huacaor'
server 'hongwangli@192.168.1.3', :app, :web, :db, :primary => true

task :copy_configuration do
  run "cp #{shared_path}/config/*.* #{release_path}/config/"
end

desc "Compile assets"
task :assets do
  run "cd /srv/huacaor/current/; RAILS_ENV=#{rails_env} bundle exec rake assets:clean; RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
end

after "deploy:update_code", :copy_configuration
#after "deploy:create_symlink", :assets 
