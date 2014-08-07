require 'digest'
require_relative 'weighted_split'

module ABSplit
  module Functions
    class Md5WeightedSplit < WeightedSplit

      MAX_HASH_VALUE = ('f' * 32).to_i(16)

      class << self
        protected
        def select_experiment_for(value, experiments)
          weight = weight(value)
          experiments = calculate_markers experiments
          experiments.each do |experiment|
            return experiment['name'] if weight <= experiment[:marker]
          end
          experiments.last['name']
        end

        def weight(value)
          100 * hash(value).to_f / MAX_HASH_VALUE
        end

        def hash(value)
          Digest::MD5.hexdigest(value.to_s).to_i(16)
        end

        def calculate_markers(experiments)
          cumulative = 0
          experiments.map do |experiment|
            cumulative += experiment['weight']
            { marker: cumulative }.merge(experiment)
          end
        end

      end
    end
  end
end
