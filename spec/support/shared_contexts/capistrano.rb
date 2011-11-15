require 'capistrano'
require 'capistrano-spec'

shared_context :capistrano do
  include Capistrano::Spec::Matchers

  let(:capistrano)  { Capistrano::Configuration.new }
  let(:recipe_name) { self.class.top_level_description }
  let(:recipe_path) { recipe(recipe_name) }
  subject         { capistrano }

  before do
    capistrano.extend Capistrano::Spec::ConfigurationExtension
    capistrano.load recipe_path
  end

  def recipe name
    "lib/o2h/recipes/#{name}"
  end
end
