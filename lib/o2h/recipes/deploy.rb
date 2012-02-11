load 'deploy'

set(:strategy) do
  require 'o2h/capistrano/deploy/strategy/git'
  Capistrano::Deploy::Strategy::Git.new(self)
end

set(:deploy_to) { "/var/www/#{domain}" }
set :group, :www

set(:shared_children) { %w(public/system log tmp/pids backup) }

set(:latest_release)  { fetch(:current_path) }
set(:release_path)    { fetch(:current_path) }
set(:current_release) { fetch(:current_path) }

set(:current_revision)  { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:latest_revision)   { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:previous_revision) { capture("cd #{current_path}; git rev-parse --short HEAD@{1}").strip }

after 'deploy:update_code', 'deploy:set_permissions', :roles => :web

namespace :deploy do

  task :set_permissions do
    # Change the owner and group of everything under the
    # deployment directory to webadmin and apache
    try_sudo "chgrp -R #{group} #{deploy_to}"
  end

  desc find_task(:default).description
  task :default do
    update
    restart
  end

  desc find_task(:setup).description
  task :setup, :except => { :no_release => true } do
    dirs = [deploy_to, shared_path]
    dirs += shared_children.map { |d| File.join(shared_path, d) }
    run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
    strategy.clone!
  end

  desc find_task(:cold).description
  task :cold do
    update
    migrate
    start
  end

  desc "Resets to HEAD of branch"
  task :update do
    transaction do
      update_code
    end
  end

  desc find_task(:update_code).description
  task :update_code, :except => { :no_release => true } do
    strategy.deploy!
    finalize_update
  end

  desc find_task(:migrations).description
  task :migrations do
    set :migrate_target, :latest
    update
    migrate
    restart
  end

  task :celanup do
    nil
  end

  task :symlink do
    nil
  end

  namespace :rollback do
    desc "Moves the repo back to the previous version of HEAD"
    task :revision, :except => { :no_release => true } do
      set :branch, "HEAD@{1}"
      deploy.update_code
    end

    desc "Rewrite reflog so HEAD@{1} will continue to point to at the next previous release."
    task :cleanup, :except => { :no_release => true } do
      run "cd #{current_path}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
    end
  end
end
