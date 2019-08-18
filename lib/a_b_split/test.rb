# frozen_string_literal: true

module ABSplit
  # This class is responsible for spliting the population using the experiment
  # name passed as a parameter. It will always return an experiment name or a
  # NoValidExperiment error in case is chosen any unknown experiment.
  class Test
    include ABSplit

    class << self
      def split(name, value)
        self.experiment = find(name)

        raise ABSplit::NoValidExperiment unless experiment

        function.value_for(value, *options)
      end

      private

      attr_accessor :experiment

      def find(experiment)
        ABSplit.configuration.experiments[experiment]
      end

      def function
        function = 'WeightedSplit'

        unless experiment.is_a?(Array)
          function = experiment['algorithm'] if experiment['algorithm']

          begin
            ABSplit::Functions.const_get(function)
          rescue NameError
            raise ABSplit::NoValidExperiment
          end
        end

        ABSplit::Functions.const_get(function)
      end

      def options
        experiment.is_a?(Array) ? experiment : experiment['options']
      end
    end
  end
end
