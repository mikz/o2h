$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.

set(:rvm_ruby, "ree")
set(:rvm_gemset) { fetch(:application) }
set(:rvm_ruby_string) { [fetch(:rvm_ruby), fetch(:rvm_gemset)].compact.join('@') }
