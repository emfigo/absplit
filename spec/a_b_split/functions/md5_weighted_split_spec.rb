# frozen_string_literal: true

require 'spec_helper'

describe ABSplit::Functions::Md5WeightedSplit do
  include_examples :weighted_split

  describe '.value_for' do
    let(:tolerance) { 0.025 }
    let(:sample_size) { 1000 * rand(10..20) }

    let(:test_run) do
      sample_size.times.map do |index|
        described_class.value_for(index * rand(1..100), *params)
      end
    end

    context 'when the weight of an option' do
      context 'falls on the bounds of probabilities' do
        params = [
          { 'name' => 'option_a', 'weight' => 100 },
          { 'name' => 'option_b', 'weight' => 0 }
        ]
        let(:params) { params }

        params.each do |param|
          it "gets #{param['name']} exactly #{param['weight']}% of the time" do
            allocated_sample_size = (param['weight'].to_f / 100) * sample_size
            expect(test_run.count { |option| option == param['name'] }).to eq(allocated_sample_size)
          end
        end
      end

      describe 'is within the bounds of probabilities' do
        params = [
          { 'name' => 'option_a', 'weight' => 60 },
          { 'name' => 'option_b', 'weight' => 10 },
          { 'name' => 'option_c', 'weight' => 30 }
        ]
        let(:params) { params }

        params.each do |param|
          it "gets #{param['name']} approximately #{param['weight']}% of the time" do
            adjusted_tolerance = sample_size.to_f * (tolerance / 2)
            allocated_sample_size = (param['weight'].to_f / 100) * sample_size
            expect(test_run.count { |option| option == param['name'] })
              .to be_within(adjusted_tolerance)
              .of(allocated_sample_size)
          end
        end
      end
    end

    it 'always returns the same option when passed the same value' do
      params = [
        { 'name' => 'option_a', 'weight' => 60 },
        { 'name' => 'option_b', 'weight' => 39 },
        { 'name' => 'option_c', 'weight' => 1 }
      ]

      value = 178_440
      expect(Array.new(100) { described_class.value_for(value, *params) }.uniq).to eq ['option_c']
    end
  end
end
