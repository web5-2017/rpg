set :stage, :staging

	server '107.170.100.249', roles: %w(app web db), primary: true, user: 'deployer'
	set :rails_env, "production"
