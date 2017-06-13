# config valid only for current version of Capistrano
		lock "3.8.1"

		set :stages, ["staging", "production"]

		set :application,     'jefferson.tsi.pro.br'
		set :branch,          'staging'

		set :user,            'deployer'
		set :repo_url,        'git@github.com:web5-2017/rpg.git'
		set :keep_releases,   3

		set :puma_threads,    [4, 16]
		set :puma_workers,    0

		# Don't change these unless you know what you're doing
		set :pty,             true
		set :use_sudo,        false
		set :deploy_via,      :remote_cache
		set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
		set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
		set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
		set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
		set :puma_access_log, "#{release_path}/log/puma.error.log"
		set :puma_error_log,  "#{release_path}/log/puma.access.log"
		set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa) }
		set :puma_preload_app, true
		set :puma_worker_timeout, nil
		set :puma_init_active_record, true  # Change to false when not using ActiveRecord

		set :format,        :pretty
		set :log_level,     :debug

		## Linked Files & Directories (Default None):
		set :linked_files, %w{config/database.yml config/secrets.yml config/smtp_config.yml}
		set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

		namespace :puma do
		  desc 'Create Directories for Puma Pids and Socket'
		  task :make_dirs do
		    on roles(:app) do
		      execute "mkdir #{shared_path}/tmp/sockets -p"
		      execute "mkdir #{shared_path}/tmp/pids -p"
		    end
		  end

		  before :start, :make_dirs
		end

		namespace :deploy do
		  desc "Make sure local git is in sync with remote."
		  task :check_revision do
		    on roles(:app) do
		      # unless `git rev-parse HEAD` == `git rev-parse origin/staging`
		      #   puts "WARNING: HEAD is not the same as origin/staging"
		      #   puts "Run `git push` to sync changes."
		      #   exit
		      # end
		    end
		  end

		  desc 'Setup Deploy'
		  task :setup do
		    on roles(:app) do
		      execute :mkdir, "-p", shared_path, releases_path
		      execute :mkdir, "-p", "#{shared_path}/config"
		      execute :touch, "#{shared_path}/config/database.yml"
		      execute :touch, "#{shared_path}/config/secrets.yml"
		    end
		  end

		  before :starting,     :check_revision
		  after  :finishing,    :compile_assets
		  after  :finishing,    :cleanup

		end

		# ps aux | grep puma    # Get puma pid
		# kill -s SIGUSR2 pid   # Restart puma
		# kill -s SIGTERM pid   # Stop puma