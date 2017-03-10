# frozen_string_literal: true
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w(--color)
  t.pattern = 'spec/**/*_spec.rb'
end

RuboCop::RakeTask.new(:rubocop)

task default: [:rubocop, :spec]

task :environment do
  require 'a_b_split'
end

task console: :environment do
  require 'pry'

  Pry.config.prompt = [
    proc { 'ABSplit> ' }
  ]

  Pry.start
end
task c: :console
