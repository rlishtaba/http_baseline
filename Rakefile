require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = '--format RspecJunitFormatter  --out rspec.xml --tag ~online'
  t.verbose    = true
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new do |t|
  t.profile = 'default'
end

task :default => [:spec, :cucumber]