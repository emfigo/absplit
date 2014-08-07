require 'spec_helper'

describe ABSplit::Functions::Md5WeightedSplit do
  include_examples :weighted_split

  describe '.value_for' do
    let(:tolerance) { 0.025 }
    let(:sample_size) { 1000 * rand(10..20) }

    let(:test_run) do
      sample_size.times.map.with_index { |index| described_class.value_for(index * rand(1..100), *params) }
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
            expect(test_run.count { |option| option == param['name'] }).to be_within(adjusted_tolerance).of(allocated_sample_size)
          end
        end
      end
    end
  end
end
