module WelcomeHelper
	def session_message
		@log_str = ""
		
		if admin_signed_in?
		  @log_str = link_to('Hi Nancy', destroy_admin_session_path , method: :get, class: "nav-link") 
		else
 		  @log_str = link_to('Admin? you need to sign-In', admin_session_path, class: "nav-link")
		end
		return raw '<span class="navbar-text log-message pull-right" >' + @log_str + '</span>'
  end
end
