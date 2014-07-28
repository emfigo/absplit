require 'bigdecimal'

module ABSplit
  module Functions
    class Sigmoid
      def self.value_for(x, *params)
        BigDecimal.new("#{1.0/(1 + Math.exp(-2 * x))}")
      end
    end
  end
end
