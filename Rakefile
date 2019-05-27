# frozen_string_literal: true

require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w[--color]
  t.pattern = 'spec/**/*_spec.rb'
end

RuboCop::RakeTask.new(:rubocop)

task default: %i[rubocop spec]
