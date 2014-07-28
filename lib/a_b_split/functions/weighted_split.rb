module ABSplit
  module Functions
    class WeightedSplit
      MAX_POSITIONS = (9999999999999999999 * 2) + 1 #capacity of Fixnum
      
      def self.value_for(x, *params)
        given_weights = validate(params)
        
        experiments = split_weights(params, params.size, given_weights)

        select_experiment_for(x, experiments)
      end

      private

      def self.validate(experiments)
        given_weights = experiments.each_with_object([]) do |param, memo| 
          memo << param['weight'] if param.has_key?('weight')
        end

        unless experiments.any? && experiments.size > 1 && given_weights.reduce(0, &:+) <= 100
          raise ABSplit::NoValidExperiment
        end

        given_weights
      end

      def self.markers(experiments)
        experiments.map do |experiment| 
          (MAX_POSITIONS * (experiment['weight'] / 100)) - ( MAX_POSITIONS / 2)
        end
      end

      def self.select_experiment_for(x, experiments)
        x_position = x.hash
        
        markers(experiments).each_with_index do |limit, i|
          if x_position <= limit
            return experiments[i]['name']
          end
        end

        experiments.last['name']
      end

      def self.split_weights(experiments, parts, given_percentage)
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
    end
  end
end
