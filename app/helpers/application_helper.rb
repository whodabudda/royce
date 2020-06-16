module ApplicationHelper

	def show_params
		@return_str = "<p> <strong> List of Parameters </strong></p>"
		params.each do |key, value| 
		  @return_str.concat ("<p> key:" + key.to_s + " value:" + value.to_s + "</p>")
		end
		@return_str.concat "<p> <strong> List of Session attributes </strong></p>"
		
	    @return_str.concat debug (session)
	    @return_str.concat "current user is: " + current_user.to_s
	    @return_str.concat "current admin is: " + current_admin.to_s
	    #or session.inspect
		

		return raw @return_str
    end

	def comment
    end

	def my_debug(str)
	   logger.debug(action_name + ": " + str.to_s) if logger.debug?
	end

	def set_log_level(lvl)
		# :debug, :info, :warn, :error, and :fatal, 0 up to 4 respectively
		ActiveRecord::Base.logger.level = lvl 
		my_debug("logger.level is now: " + config.logger_level?.to_s)
	end
    def delivery_method
        Rails.env == "production" ? 'deliver_later' : 'deliver_now'
    end

end
