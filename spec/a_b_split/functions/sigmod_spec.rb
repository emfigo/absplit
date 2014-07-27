require 'spec_helper'

describe ABSplit::Functions::Sigmoid do
  let(:sigmoid) { lambda { |x| 1.0/(1 + Math.exp(-2 * x))} }
  let(:x) { Math::E }

  describe '.value_for' do
    it 'returns the logistic function output' do
      expect(described_class.value_for(x)).to eql(sigmoid[x])
    end
  end
end
