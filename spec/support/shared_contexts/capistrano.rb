require 'capistrano'
require 'capistrano-spec'

shared_context :capistrano do
  include Capistrano::Spec::Matchers

  let(:capistrano)  { Capistrano::Configuration.new }
  let(:recipe_name) { self.class.top_level_description }
  let(:recipe_path) { recipe(recipe_name) }

  subject           { capistrano }

  before(:each) do
    capistrano.extend Capistrano::Spec::ConfigurationExtension
    capistrano.load recipe_path
  end

  let(:task) do
    task = self.class.ancestors.map do |example|
      break $1 if /^(.+?) task$/ =~ example.description
    end

    if task
      task = "#{recipe_name}:#{task}"
      capistrano.find_task(task) or raise "Task #{task} not found"
    end
  end


  def recipe name
    Dir["lib/o2h/recipes/**/*.rb"].find do |recipe|
      File.basename(recipe, '.rb') == name
    end
  end
end
