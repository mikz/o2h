require "rvm/capistrano"

set(:rvm_ruby, "ree")
set(:rvm_type, :system)
set(:rvm_gemset) { fetch(:application) }
set(:rvm_ruby_string) { [fetch(:rvm_ruby), fetch(:rvm_gemset)].compact.join('@') }
