require File.dirname(__FILE__) + '/version'

def rake_task(taskname)
  rake = fetch(:rake, "rake")
  rake_env = fetch(:rake_env, "")
  in_rails_root("#{rake} #{rake_env} #{taskname}")
end

def in_rails_root(taskname)
  rails_env = fetch(:rails_env, "production")
  directory = current_release
  run %{cd #{directory}; RAILS_ENV=#{rails_env} #{taskname}}
end

Dir[File.join(File.dirname(__FILE__), 'recipes', '*.rb')].each do |recipe|
  O2h.capistrano.load recipe
end
