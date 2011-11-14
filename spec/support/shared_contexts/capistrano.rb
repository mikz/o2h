require 'capistrano'
require 'capistrano-spec'

shared_context :capistrano do
  let(:capistrano)  { Capistrano::Configuration.new }
  let(:recipe_name) { self.class.top_level_description }
  let(:recipe_path) { recipe(recipe_name) }
  subject         { capistrano }

  before do
    capistrano.load recipe_path
  end

  def recipe name
    "lib/o2h/recipes/#{name}"
  end
end
