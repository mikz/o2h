set :scm, :git
set :branch, :master

set :migrate_target,  :current
set :deploy_via, :remote_git

#set :git_shallow_clone, true
set :git_enable_submodules, true

set(:repository) { "git.o2h.cz:#{fetch(:application)}" }
