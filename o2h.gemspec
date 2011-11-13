# -*- encoding: utf-8 -*-
require File.expand_path('../lib/o2h/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Michal Cichra"]
  gem.email         = ["michal@o2h.cz"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "o2h"
  gem.require_paths = ["lib"]
  gem.version       = O2h::VERSION

  gem.add_dependency 'newrelic_rpm', '>= 3.3.0'
  #gem.add_dependency 'bundler', '>= 1.1.0'
end
