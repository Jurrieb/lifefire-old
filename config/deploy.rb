# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'lifefire'
set :repo_url, 'git://github.com/loed-idzinga/lifefire.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :branch, 'master'

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/root/rails_apps/lifefire'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
#set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads public/assets}

# Default value for default_env is {}
set :default_env, { path: "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

# set :normalize_asset_timestamps, false
# set :normalize_asset_timestamps, %{public/images public/javascripts public/stylesheets}


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      puts "**********************************************"
      puts "*         APPLICATION IS RESTARTING          *"
      puts "**********************************************"
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  # namespace :assets do
  #   desc 'Run the precompile task locally and rsync with shared'
  #   task :precompile, :roles => :web, :except => { :no_release => true } do
  #     puts "**********************************************"
  #     puts "*       APPLICATION IS PRECOMPILING          *"
  #     puts "**********************************************"
  #     %x{bundle exec rake assets:precompile}
  #     %x{rsync --recursive --times --rsh=ssh --compress --human-readable --progress public/assets #{domain}:#{assets_path}}
  #     %x{bundle exec rake assets:clean}
  #   end
  # end

  # after "deploy", "assets:precompile"
  after "deploy", "deploy:migrate"
  after :publishing, :restart
  after :finishing, 'deploy:cleanup'
end
