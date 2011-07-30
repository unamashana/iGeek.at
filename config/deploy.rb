require 'rvm/capistrano'

set :application, "igeek.at"
set :repository,  "git@github.com:prateekdayal/iGeek.at.git"

set :scm, :git
set :ssh_options, { :forward_agent => true }
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
#
set :deploy_to, "/home/rails/apps/#{application}"

# Server is defined in stage specific file
set :user, 'rails'    
set :rvm_ruby_string, '1.9.2' # Defaults to 'default'

#set :scm_user,  Proc.new { Capistrano::CLI.ui.ask("SVN username: ")}
#set :scm_password, Proc.new { Capistrano::CLI.password_prompt("SVN password for #{scm_user}: ")} 
#set :repository, Proc.new { "--username #{scm_user} --password #{scm_password} #{repository_url}" } 
set :deploy_via, :remote_cache

set :use_sudo,  false

server "78.47.119.86", :app, :web, :db, :primary => true

#after "deploy:update_code", "igeek_at:config", "bundler:bundle_new_release"
after "deploy:update_code", "bundler:bundle_new_release"
after "deploy", "deploy:cleanup"

namespace(:igeek_at) do
  task :config,  :roles => :app do
    %w(database.yml).each do |file|
      run <<-CMD
        ln -nfs #{shared_path}/system/#{file} #{release_path}/config/#{file}
      CMD
    end
  end

  task :symlink, :roles => :app do
    run <<-CMD
      ln -nfs #{shared_path}/assets/uploads #{release_path}/public/uploads
    CMD

    run <<-CMD
      rm #{release_path}/public/system
    CMD
  end
end

namespace :bundler do
  task :create_symlink, :roles => :app do
    shared_dir = File.join(shared_path, 'bundle')
    release_dir = File.join(current_release, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end
  
  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} && bundle install --without test --without development --deployment"
  end
  
  task :lock, :roles => :app do
    run "cd #{current_release} && bundle lock;"
  end
  
  task :unlock, :roles => :app do
    run "cd #{current_release} && bundle unlock;"
  end
end

namespace(:deploy) do
  task :restart, :role => :app do
    run <<-CMD
      cd #{release_path} && bundle exec rake db:migrate RAILS_ENV=production --trace
    CMD
    run <<-CMD
      cd #{release_path} && bundle exec rake db:seed RAILS_ENV=production --trace
    CMD
    run <<-CMD
      cd #{release_path} && touch tmp/restart.txt
    CMD
  end
end


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
