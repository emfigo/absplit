# frozen_string_literal: true
require 'spec_helper'

describe ABSplit::Functions::HeavisideWeightedSplit do
  include_examples :weighted_split

  describe '.value_for' do
    let(:params) do
      [
        { 'name' => 'experimentA' },
        { 'name' => 'experimentB' }
      ]
    end

    context 'when is a none numeric value' do
      let(:value) { nil }

      it 'always returns the same option when passed the same value' do
        expect(Array.new(100) { described_class.value_for(x, *params) }.uniq).to eq(['experimentB'])
      end
    end

    context 'when is a numeric value' do
      context 'and is in the first part of the espectrum' do
        let(:x) { -2 }

        it 'returns the logistic function output' do
          expect(described_class.value_for(x, *params)).to eql('experimentA')
        end
      end

      context 'and is in the last part of the espectrum' do
        let(:x) { Math::E }

        it 'returns the logistic function output' do
          expect(described_class.value_for(x, *params)).to eql('experimentB')
        end
      end
    end
  end
end
