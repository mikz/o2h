set(:domain) { abort "You need to set the :domain variable, e.g set :domain 'www.example.com'" }
set(:application) { domain.split('.').first } # TODO - find proper 2nd level domain

set :use_sudo, false
set :sudo, 'sudo -n'
set :sudo_prompt, ''
set :password, ''

default_run_options[:pty] = true

ssh_options[:forward_agent] = true
