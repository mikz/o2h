module O2h
  extend self

  autoload :VERSION, 'o2h/version'

  def capistrano(required = :require)
    defined?(Capistrano) and Capistrano::Configuration.instance(required)
  end

  def initialize!
    # use app mode only when we are not in capistrano
    unless capistrano(false)
      app_mode
    end
  end

  def app_mode
    require 'newrelic_rpm'
  end

  def host(recipe)
    File.expand_path(File.join(%w{o2h recipes host} << recipe + ".rb"), File.dirname(__FILE__))
  end
end

O2h.initialize!
