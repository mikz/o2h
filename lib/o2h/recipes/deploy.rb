set(:deploy_to) { "/var/www/#{domain}" }
set :group, :www

after :deploy, 'deploy:set_permissions', :roles => :web

namespace :deploy do
  task :set_permissions do
    # Change the owner and group of everything under the
    # deployment directory to webadmin and apache
    run "chgrp -R #{group} #{deploy_to}"
  end
end
