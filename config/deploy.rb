# config valid only for Capistrano 3.1
lock '3.1.0'

set :user, "cutthechi"
set :domain, "azcutthechi.com"


set :application, 'azcutthechi.com'

set :pty, true # Default value for :pty is false

# set :repo_url, 'git@github.com:sdthornton/for-kevin.git'
set :repo_url, '.'
set :scm, :none # Default value for :scm is :git
set :deploy_via, :copy

set :checkout, 'export'

set :user, 'cutthechi'
set :use_sudo, false
set :domain, 'azcutthechi.com'
set :applicationdir, "home/#{:user}/#{:application}"
set :deploy_to, :applicationdir

role :web, :domain
role :app, :domain
role :db, :domain, primary: true

set :chmod755, "app config db lib public vendor public/disp*"

set :rails_env, "production"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
