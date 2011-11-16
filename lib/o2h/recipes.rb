require File.dirname(__FILE__) + '/version'

Dir[File.join(File.dirname(__FILE__), 'recipes', '*.rb')].each do |recipe|
  O2h.capistrano.load recipe
end
