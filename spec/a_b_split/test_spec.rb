require 'spec_helper'

describe ABSplit::Test do
  let(:x) { 'testa123' }
  let(:experiment) { { experiment:
                          [ { name: 'optiona', weight: 50 },
                            { name: 'optionb'} ]
                    } }
  describe '.split' do
    context 'when no experiment file is specified' do
      before do
        ABSplit.configure
      end
      
      it 'splits the experiment with the default function' do
        expect{ described_class.split(:experiment, x) }.to raise_error(ABSplit::NoValidExperiment)
      end
    end

    context 'when an experiment file is specified' do
      before do
        ABSplit.configure do |config|
          config.experiments = experiment 
        end
      end

      it 'splits the experiment with the default function' do
        expect(ABSplit::Functions::WeightedSplit).to receive(:value_for).with(x, *experiment[:experiment])

        described_class.split(:experiment, x)
      end
    end
  end
end
