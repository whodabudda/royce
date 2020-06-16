desc "task sandbox"
task :test_task do
  on roles(:app) do
      puts "first env"
      puts "testing 2.3.1 env"
      set :bundle_env_variables, { bundle_deployment: true }

      within  '/home/whodabudda/sites/pbstage/releases/20200411163059' do
        with fetch(:bundle_env_variables) do
          execute :env
          if test :bundle, :check
            info "Yaaa, it passed"
          else
            execute :bundle, :install
          end
        end
      end
#      puts "testing 2.6.1 env"
#      execute ('cd  /home/whodabudda/sites/pbstage/releases/20200412142352; env; bundle check') 
end
end
