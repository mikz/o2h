source :rubygems

gemspec

group :development do
  gem 'rake'

  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'guard-bundler'

  gem 'ruby-debug', :platforms => :mri_18
  gem 'ruby-debug19', :platforms => :mri_19
end

group :test do
  gem 'spork', '>= 0.9.0.rc9', :require => false

  gem 'rspec'

  gem 'capistrano-spec'
end

group :darwin do
  gem 'rb-fsevent'
  gem 'growl_notify'
end
