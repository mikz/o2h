namespace :deploy do

  task :start do ; end
  task :stop do ; end

  desc "Restart Application"
  task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

end
