lock '3.2.1'

set :application, 'lifefire'
set :repo_url, 'git://github.com/loed-idzinga/lifefire.git'
set :branch, 'master'
set :deploy_to, '/root/rails_apps/lifefire'
set :scm, :git
set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads public/assets}

set :default_env, { path: "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH" }

set :keep_releases, 5

set :normalize_asset_timestamps, true
set :normalize_asset_timestamps, %{public/images public/assets public/uploads public/javascripts public/stylesheets}


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

  desc "reload the database with seed data"
  task :seed do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "db:seed"
        end
      end
    end
  end


  after "deploy", "deploy:migrate"
  after :publishing, :restart
  after :finishing, 'deploy:cleanup'
end
