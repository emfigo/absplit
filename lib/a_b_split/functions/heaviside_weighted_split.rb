# frozen_string_literal: true
require 'bigdecimal'
require_relative 'weighted_split'

module ABSplit
  module Functions
    # Weighted split based on a modified Heaviside function. In case a numeric value
    # is passed, it uses a sigmoid function applying a modified Heaviside to choose
    # the experiment. In case a none numeric value is passed it uses SHA2 algorithm
    # to get a value from the object, and after decide based on weights.
    #
    # Persistent - Supports 256 bits as input
    #
    # No collisions are possible
    class HeavisideWeightedSplit < WeightedSplit
      MAX_HASH_VALUE = ('f' * 64).to_i(16)

      class << self
        protected

        def select_experiment_for(value, experiments)
          x = value.is_a?(Numeric) ? value : hash(value)

          heaviside(x, experiments)
        end

        private

        def hash(value)
          (sha256(value) - (MAX_HASH_VALUE / 2)).to_f / (MAX_HASH_VALUE / 2)
        end

        def sha256(value)
          Digest::SHA256.hexdigest(value.to_s).to_i(16)
        end

        def heaviside(value, experiments)
          x = sigmoid(value)
          accumulated_percentages = 0

          experiments.each do |experiment|
            accumulated_percentages += percentage(experiment)

            return experiment['name'] if x < accumulated_percentages
          end
        end

        def percentage(experiment)
          experiment['weight'].to_f / 100
        end

        def sigmoid(x)
          BigDecimal.new((1.0 / (1 + Math.exp(-2 * x))).to_s)
        end
      end
    end
  end
end
