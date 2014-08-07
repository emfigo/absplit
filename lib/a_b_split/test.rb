module ABSplit
  module Test
    extend self

    def split(name, x)
      self.experiment = find(name)

      raise ABSplit::NoValidExperiment unless experiment

      function.value_for(x,*options)
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
