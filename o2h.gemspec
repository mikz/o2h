# -*- encoding: utf-8 -*-
require File.expand_path('../lib/o2h/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Michal Cichra"]
  gem.email         = ["michal@o2h.cz"]
  gem.description   = %q{Collection of recipes and gem dependencies for o2h deployment}
  gem.summary       = gem.description
  gem.homepage      = "http://o2h.cz"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "o2h"
  gem.require_paths = ["lib"]
  gem.version       = O2h::VERSION

  gem.add_dependency 'newrelic_rpm', '~> 3.3'
  gem.add_dependency 'capistrano', '~> 2.9'
  gem.add_dependency 'rvm-capistrano', '~> 1.0'
  gem.add_dependency 'pg_dumper', '~> 0.1.7'
end
