source :rubygems

gemspec

group :development do
  gem 'rake'

  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'guard-bundler'

  gem 'ruby-debug', :platforms => :mri_18
  gem 'debugger', :platforms => :mri_19
end

group :test do
  gem 'spork', '>= 0.9.0.rc9', :require => false

  gem 'rspec'

  gem 'capistrano-spec'

  gem 'simplecov', :require => false, :platforms => :mri_19
end

group :darwin do
  gem 'rb-fsevent'
  gem 'growl_notify'
end
