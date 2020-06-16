require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Royce
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.before_configuration do
		env_file = File.join(Rails.root, '/config/', 'local_env.yml')
		if File.exists?(env_file)
			config_keys = YAML.load(File.read(env_file))[Rails.env]
   			config_keys.each do |key, value|
   				ENV[key.to_s.upcase] = value
   			end
    	end
    end
    # PPK 09/09/2019 These paths will be ignored when redirecting the user to last visited page
 	# Devise routes need to always be here, so that a redirect loop does not occur
	# after signing in
	config.ignored_paths = %W(/users/sign_in /users/sign_up /users/password /users/sign_out /users/confirm_password /users/password/edit /users/password/new /admins/sign_in /admins/sign_up /admins/password/edit /admins/password /admins/sign_out /admins/confirm_password)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
	#TODO: find out how much of this loading is needed in a Rails 6.x with Zeitwerk
    config.enable_dependency_loading = true
  	config.eager_load_paths += %W(#{config.root}/lib/classes)
    config.autoload_paths += %W(#{config.root}/lib/classes)  #ppk 12/07/19 auto include custom classes
    config.active_storage.replace_on_assign_to_many = false  #ppk needed to prevent new multiple assignments
							     #from replacing all existing assignments
   # config.active_job.queue_adapter = :sidekiq  #ppk 12/21/2019  added sidekiq gem
  end
end
