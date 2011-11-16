module O2h
  extend self

  autoload :VERSION, 'o2h/version'


  def capistrano(required = :require)
    defined?(Capistrano) and Capistrano::Configuration.instance(required)
  end

  def initialize!
    if capistrano(false)
      app_mode
    else
      cap_mode
    end
  end

  def app_mode
    require 'o2h/recipes'
  end

  def cap_mode
    require 'newrelic_rpm'
  end
end

O2h.initialize!
