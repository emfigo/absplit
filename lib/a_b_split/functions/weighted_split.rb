module ABSplit
  module Functions
    class WeightedSplit
      MAX_POSITIONS = (9999999999999999999 * 2) + 1 #capacity of Fixnum

      class << self 

        def value_for(x, *params)
          given_weights = validate(params)

          experiments = split_weights(params, params.size, given_weights)

          select_experiment_for(x, experiments)
        end

        protected

        def validate(experiments)
          given_weights = experiments.each_with_object([]) do |param, memo| 
            memo << param['weight'] if param.has_key?('weight')
          end

          unless experiments.any? && experiments.size > 1 && given_weights.reduce(0, &:+) <= 100
            raise ABSplit::NoValidExperiment
          end

          given_weights
        end

        def split_weights(experiments, parts, given_percentage)
          return experiments if given_percentage.size >= parts

          missing_weights = parts - given_percentage.size
          missing_percentage = 100 - given_percentage.reduce(0, &:+)

          experiments.map do |experiment| 
            if experiment['weight']
              experiment['weight'] = experiment['weight'].to_f
            else
              experiment['weight'] = missing_percentage.to_f / missing_weights.to_f
            end

            experiment
          end
        end
        
        def select_experiment_for(x, experiments)
          x_position = x.hash

          markers(experiments).each_with_index do |limit, i|
            if x_position <= limit
              return experiments[i]['name']
            end
          end

          experiments.last['name']
        end

        private

        def markers(experiments)
          experiments.map do |experiment| 
            (self::MAX_POSITIONS * (experiment['weight'] / 100)) - (self::MAX_POSITIONS / 2)
          end
        end
      end
    end
  end
end
