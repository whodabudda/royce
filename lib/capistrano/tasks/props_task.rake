desc "Show the properties of a all roles"
task :props do
	fetch(:my_roles).each do |r|
	 puts "get properties on: #{r.inspect}"
	 rps = role_properties(r.to_sym)
	 rps.each do |props|
		  puts props.inspect
	 end
	end
    puts "will deploy_to #{fetch(:deploy_to)}"
end
