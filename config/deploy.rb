set :user, "kreditmarket"

set :application, "tuam"

role :app, "blacklist.kreditmarket.com"
role :web, "blacklist.kreditmarket.com"
role :db,  "blacklist.kreditmarket.com", :primary => true

set :scm, "git"
set :repository,  "git@github.com:adammiribyan/tuam.git"
set :deploy_via, :remote_cache

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :keep_releases, 10
set :use_sudo, false

set :branch, "master"
set :deploy_to, "/home/#{user}/webapps/#{application}"

set :shared_children, %w(system log pids config db)

# automatically sets the environment based on presence of 
# :stage (multistage gem), :rails_env, or RAILS_ENV variable; otherwise defaults to 'production'
def environment  
  if exists?(:stage)
    stage
  elsif exists?(:rails_env)
    rails_env  
  elsif(ENV['RAILS_ENV'])
    ENV['RAILS_ENV']
  else
    "production"  
  end
end

# Execute a rake task, example:
#   run_rake log:clear
def run_rake(task)
  run "cd #{current_path} && rake #{task} RAILS_ENV=#{environment}"
end

require 'erb'
namespace :db do
  desc "Create database.yml in shared path with settings for current stage and test env"
  task :create_yaml do    
    db_config = ERB.new <<-EOF
    base: &base
      adapter: sqlite3
      database: db/#{environment}.sqlite3
		  pool: 5
		  timeout: 5000

    #{environment}:
      <<: *base
    EOF

    put db_config.result, "#{shared_path}/config/database.yml"
  end
  
  desc "Moving sqlite3 data to shared path before uploading a new release"
  task :move_to_shared do
    run "#{sudo} mv #{db_path}production.sqlite3 #{shared_db_path}production.sqlite3"
  end
end

unless exists?(:config_files)
  set :config_files, %w(database.yml)
end

namespace :symlink do
  desc <<-DESC
  Create shared directories. Specify which directories are shared via:
    set :shared_dirs, %w(avatars videos)
  DESC
  task :create_shared_dirs, :roles => :app do
    shared_dirs.each { |link| run "mkdir -p #{shared_path}/#{link}" } if shared_dirs
  end
  
  desc <<-DESC
  Create links to shared directories from current deployment's public directory.
  Specify which directories are shared via:
    set :shared_dirs, %w(avatars videos)
  DESC
  task :shared_directories, :roles => :app do
    shared_dirs.each do |link| 
      run "rm -rf #{release_path}/public/#{link}"
      run "ln -nfs #{shared_path}/#{link} #{release_path}/public/#{link}" 
    end if shared_dirs
  end
  
  desc <<-DESC
  Create links to config files stored in shared config directory.
  Specify which config files to link using the following:
    set :config_files, 'database.yml'
  DESC
  task :shared_config_files, :roles => :app do
    config_files.each do |file_path|
      begin
        run "#{sudo} rm -f #{config_path}#{file_path}"         
        run "#{sudo} ln -nfs #{shared_config_path}#{file_path} #{config_path}#{file_path}"
      rescue
        puts "Problem linking to #{file_path}. Be sure file already exists in #{shared_config_path}."
      end
    end if config_files
  end
  
end

def config_path
  "#{current_release}/config/"
end

def db_path
  "#{current_release}/db/"
end

def shared_config_path
  "#{shared_path}/config/"
end

def shared_db_path
  "#{shared_path}/db/"
end

namespace :deploy do
  desc "Restart application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after "deploy:setup", "symlink:create_shared_dirs"
after "deploy:update_code", "symlink:shared_directories"
after "deploy:update_code", "symlink:shared_config_files"
after "deploy", "deploy:cleanup"