require 'capistrano'
require 'capistrano-spec'

shared_context :capistrano do
  let(:capistrano)  { Capistrano::Configuration.new }
  let(:recipe_name) { self.class.top_level_description }
  let(:recipe_path) { "lib/o2h/recipes/#{recipe_name}" }
  subject         { capistrano }

  before do
    capistrano.load recipe_path
  end
end
