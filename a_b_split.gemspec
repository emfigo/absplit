# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('.')
require 'lib/a_b_split/version'

Gem::Specification.new do |s|
  s.name           = 'a_b_split'
  s.version        = ABSplit::VERSION
  s.date           = Time.now.strftime('%Y-%m-%d').to_s
  s.summary        = 'Splits experiment cohorts for A/B testing'
  s.license        = 'MIT'
  s.authors        = ['Enrique M Figuerola Gomez']
  s.email          = 'me@emfigo.com'
  s.files          = Dir.glob('lib/**/*')
  s.require_paths  = ['lib']
  s.homepage       = 'https://emfigo.com/portfolio'

  s.required_ruby_version = '>= 2.3'

  s.add_development_dependency 'pry', '~> 0.12'
  s.add_development_dependency 'rake', '~> 12.3'
  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'rubocop', '~> 0.70'
end
