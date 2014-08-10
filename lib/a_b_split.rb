$:.unshift File.expand_path('..', __FILE__)

require 'a_b_split/functions'
require 'a_b_split/configuration'
require 'a_b_split/test'
require 'yaml'

module ABSplit
  class NoValidExperiment < RuntimeError; end
end

module ABSplit
  extend self

  attr_accessor :configuration

  def configure
    yield(configuration) if block_given?
  end
end

ABSplit.configuration = ABSplit::Configuration.new
