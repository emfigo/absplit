require 'spec_helper'

describe ABSplit::Functions::WeightedSplit do
  let(:x) { nil }
      
  describe '.value_for' do
    context 'when no percentages are given' do
      it 'raises an error' do
        expect{ described_class.value_for(x) }.to raise_error(ABSplit::NoValidExperiment)
      end
    end
    
    context 'when no percentages are given' do
      context 'when there is only one experiment' do
        let(:params) { [{ 'name' => 'experimentA'}] }

        it 'raises an error' do
          expect{ described_class.value_for(x) }.to raise_error(ABSplit::NoValidExperiment)
        end
      end
      
      context 'when there are 2 experiments' do
        let(:params) { [{ 'name' => 'experimentA'}, 
                        { 'name' => 'experimentB'}] }


        it 'returns an experiment with 50% chance' do
          experiment = described_class.value_for(x, *params)

          expect(['experimentA','experimentB']).to include(experiment)
        end
      end

      context 'when there are more than 2 experiments' do
        let(:params) { [{ 'name' => 'experimentA'}, 
                        { 'name' => 'experimentB'},
                        { 'name' => 'experimentC'}] }


        it 'returns an experiment with equitative chance' do
          experiment = described_class.value_for(x, *params)

          expect(['experimentA','experimentB', 'experimentC']).to include(experiment)
        end
      end
    end
    
    context 'when some percentages are given' do
      let(:params) { [{ 'name' => 'experimentA', 'weight' => 100 }, 
                      { 'name' => 'experimentB' }] }


      it 'returns weighted split based on the given parameters' do
        expect(described_class.value_for(x, *params)).to eql('experimentA')
      end
    end

    context 'when all percentages are given' do
      let(:params) { [{ 'name' => 'experimentA', 'weight' => 100 }, 
                      { 'name' => 'experimentB', 'weight' => 0 }] }


      it 'returns a weighted split based on the parameters' do
        expect(described_class.value_for(x, *params)).to eql('experimentA')
      end
    end
  end
end
