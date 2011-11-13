set :scm, :git
set :branch, :master

set :deploy_via, :remote_cache

set :git_shallow_clone, 1
set :git_enable_submodules, 1

set(:repository) { "git.o2h.cz:#{application}" }
