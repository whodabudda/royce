desc "copy shared files after deploy"
task :copy_shared_files do
  set :shared_directory_path ,  "#{fetch(:deploy_to)}/shared"

  set :linked_files_as_string , fetch(:linked_files).join(" ")

  on roles(:app) do |host|
  	puts fetch(:linked_files)
   	execute "mkdir -p #{fetch(:shared_directory_path)}" 
    execute "mkdir -p #{fetch(:release_path)}" 
    execute "mkdir -p #{fetch(:release_path)}/app/assets/stylesheets" 
    if test("[ -d #{fetch(:shared_directory_path)} ]")
     run_locally do
     	execute " cd #{Dir.pwd}; rsync -a --relative #{fetch(:linked_files_as_string)} #{host}:#{fetch(:shared_directory_path)} " 
      execute " cd #{Dir.pwd}; rsync -a --relative node_modules #{host}:#{fetch(:release_path)} " 
     end

#      	upload! fetch(:linked_files), fetch(:shared_directory_path)
    else
     	error "#{fetch(:shared_directory_path)} does not exist on #{host}"
#     	execute "mkdir -p #{fetch(:shared_directory_path)}" 
#    	if test("[ -d #{fetch(:shared_directory_path)} ]")
#			upload! fetch(:linked_files), fetch(:shared_directory_path)
#		else
#	     	error "#{fetch(:shared_directory_path)} unable to create on #{host}"
#	    end
    end
  end
end
