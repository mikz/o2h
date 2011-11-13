set(:deploy_to) { "/var/www/#{application}" }
set :group, :www

server domain, :web, :app, :db

task :set_permissions do
  # Change the owner and group of everything under the
  # deployment directory to webadmin and apache
  run "chgrp -R #{group} #{deploy_to}"
end

after :deploy, :set_permissions, :roles => :web
