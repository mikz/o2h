require 'rubygems'
require 'bundler/setup'
require 'pathname'

#Bundler.require :default, :test

RSpec.configure do |config|
  # some (optional) config here
end

Dir[Pathname.pwd.join(*%w{spec support ** *.rb}).expand_path].each do |file|
  require file
end
