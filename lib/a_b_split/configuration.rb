module ABSplit
  class Configuration
    attr_accessor :experiments

    def initialize
      @experiments = Hash.new
    end
  end
end
