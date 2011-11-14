set :scm, :git
set :branch, :master

set :deploy_via, :remote_cache

set :git_shallow_clone, true
set :git_enable_submodules, true

set(:repository) { "git.o2h.cz:#{application}" }
