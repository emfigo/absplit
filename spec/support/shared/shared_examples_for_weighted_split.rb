# frozen_string_literal: true
shared_examples :weighted_split do
  let(:x) { nil }

  describe '.value_for' do
    subject { described_class.value_for(x, *params) }

    context 'when no options are given' do
      let(:params) { [] }
      it 'raises an error' do
        expect { subject }.to raise_error(ABSplit::NoValidExperiment)
      end
    end

    context 'when no percentages are given' do
      context 'when there is only one experiment' do
        let(:params) do
          [
            { 'name' => 'experimentA' }
          ]
        end

        it 'raises an error' do
          expect { subject }.to raise_error(ABSplit::NoValidExperiment)
        end
      end

      context 'when there are 2 experiments' do
        let(:params) do
          [
            { 'name' => 'experimentA' },
            { 'name' => 'experimentB' }
          ]
        end

        it 'returns an experiment with 50% chance' do
          expect(%w(experimentA experimentB)).to include(subject)
        end
      end

      context 'when there are more than 2 experiments' do
        let(:params) do
          [
            { 'name' => 'experimentA' },
            { 'name' => 'experimentB' },
            { 'name' => 'experimentC' }
          ]
        end

        it 'returns an experiment with equitative chance' do
          expect(%w(experimentA experimentB experimentC)).to include(subject)
        end
      end
    end

    context 'when some percentages are given' do
      let(:params) do
        [
          { 'name' => 'experimentA', 'weight' => 100 },
          { 'name' => 'experimentB' }
        ]
      end

      it 'returns weighted split based on the given parameters' do
        expect(subject).to eql('experimentA')
      end
    end

    context 'when all percentages are given' do
      let(:params) do
        [
          { 'name' => 'experimentA', 'weight' => 100 },
          { 'name' => 'experimentB', 'weight' => 0 }
        ]
      end

      it 'returns a weighted split based on the parameters' do
        expect(subject).to eql('experimentA')
      end
    end
  end
end
