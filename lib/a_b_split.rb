# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('..', __FILE__)

require 'a_b_split/functions'
require 'a_b_split/configuration'
require 'a_b_split/test'
require 'yaml'

module ABSplit
  class NoValidExperiment < RuntimeError; end

  def configuration
    @configuration
  end

  def configuration=(config)
    @configuration = config
  end

  def configure
    yield(configuration) if block_given?
  end

  module_function :configure, :configuration, :configuration=
end

ABSplit.configuration = ABSplit::Configuration.new
