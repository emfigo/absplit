module ABSplit
  module Test
    def self.split(name, x)
      experiment = ABSplit.configuration.experiments[name]

      raise ABSplit::NoValidExperiment unless experiment

      ABSplit::Functions::WeightedSplit.value_for(x,*experiment)
    end
  end
end
