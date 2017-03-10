# frozen_string_literal: true

module ABSplit
  # This class represents the configurations used in ABSplit. Every time
  # that is instanciated contains the following:
  #   - An empty list of experiments to use
  class Configuration
    attr_accessor :experiments

    def initialize
      @experiments = {}
    end
  end
end
