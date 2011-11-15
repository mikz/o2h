source :rubygems

gemspec

gem 'rake'

gem 'guard'
gem 'guard-rspec'
gem 'guard-spork'

group :test do
  gem 'spork', '>= 0.9.0.rc9', :require => false
  gem 'rspec'
  gem 'capistrano-spec'
end

group :darwin do
  gem 'rb-fsevent'
  gem 'growl_notify'
end
