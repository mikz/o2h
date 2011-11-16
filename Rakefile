#!/usr/bin/env rake
require "bundler/gem_tasks"

require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

desc 'Run Spec suite and measure coverage'
task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task['spec'].invoke
end
