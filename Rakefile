require 'rspec'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w[--color]
  t.pattern = 'spec/**/*_spec.rb'
end

task :default => :spec

task :environment do
  require 'a_b_split'
end

task :console => :environment do
  require 'pry'

  Pry.config.prompt = [
    proc { 'ABSplit> ' }
  ]

  Pry.start
end
task :c => :console
