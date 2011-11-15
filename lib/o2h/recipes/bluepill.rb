set :bluepill, "`which system_bluepill`"

before "deploy:update", "bluepill:stop"
after "deploy:update", "bluepill:start"

namespace :bluepill do

  desc "Stop processes that bluepill is monitoring and quit bluepill"
  task :quit, :roles => [:app] do
    sudo "#{bluepill} stop"
    sudo "#{bluepill} quit"
  end

  desc "Stop processes that bluepill is monitoring"
  task :stop, :roles => [:app] do
    on_rollback { start }

    sudo "#{bluepill} stop; true"
  end

  desc "Load bluepill configuration and start it"
  task :start, :roles => [:app] do
    app = fetch(:application)
    cmd = []

    cmd << try_sudo unless try_sudo.empty?

    if fetch(:silverlight, false)
      cmd << fetch(:bluepill_silverlight, %{LM_CONTAINER_NAME=background_jobs LM_TAG_NAMES=background_jobs:bluepill:#{app}})
    end

    cmd << fetch(:bluepill) << 'load' << File.join(current_path, 'config', 'bluepill', 'production.pill')

    run cmd.compact.join(" ")
  end

  desc "Prints bluepills monitored processes statuses"
  task :status, :roles => [:app] do
    sudo "#{bluepill} status"
  end

end
