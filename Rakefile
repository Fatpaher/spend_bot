require 'rubygems'
require 'bundler/setup'
require 'rake'
require 'rspec/core/rake_task'

Dir.glob('lib/tasks/*.rake').each { |r| load r}

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
