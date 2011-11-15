require 'spork'

Spork.prefork do

  require 'rspec'
  require 'pathname'
  require 'capistrano'

  #Bundler.require :default, :test

  RSpec.configure do |config|
    # some (optional) config here
  end

end

Spork.each_run do

  Dir[Pathname.pwd.join(*%w{spec support ** *.rb}).expand_path].each do |file|
    require file
  end

end
