require 'bigdecimal'
require_relative 'weighted_split'

module ABSplit
  module Functions
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
          BigDecimal.new("#{1.0/(1 + Math.exp(-2 * x))}")
        end
      end
    end
  end
end
