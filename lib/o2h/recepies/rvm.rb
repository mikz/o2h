$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.

set(:rvm_ruby, "ree")
set(:rvm_gemset) { application.split('.').first }
set(:rvm_ruby_string) { [rvm_ruby, rvm_gemset].compact.join('@') }
