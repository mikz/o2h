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

end

O2h.initialize!
