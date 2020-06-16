desc "Check that we can access everything"
task :check_write_permissions do
  on roles(:all) do |host|
    if test("[ -w #{fetch(:deploy_to)} ]")
      info "#{fetch(:deploy_to)} is writable on #{host}"
    else
      error "#{fetch(:deploy_to)} is not writable on #{host}"
    end
  	puts ":host is #{fetch(:host)}"
    puts "host is #{host}"
    puts "local pwd is #{Dir.pwd}"
  end
end
