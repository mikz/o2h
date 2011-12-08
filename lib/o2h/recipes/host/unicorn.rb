set(:unicorn_binary){ "bundle exec unicorn" }
set(:unicorn_config){ "config/unicorn.rb" }
set(:unicorn_pid){ "#{shared_path}/pids/unicorn.pid" }

namespace :deploy do
  desc "Zero-downtime restart of Unicorn"
  task :restart, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{unicorn_pid}`"
  end

  desc "Start unicorn"
  task :start, :except => { :no_release => true } do
    run "cd #{current_path}; #{unicorn_binary} -E #{rails_env} -c #{unicorn_config} -D"
  end

  desc "Stop unicorn"
  task :stop, :except => { :no_release => true } do
    run "kill -s QUIT `cat #{unicorn_pid}`"
  end
end
