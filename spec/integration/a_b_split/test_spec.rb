# frozen_string_literal: true

require 'spec_helper'
require 'yaml'

describe ABSplit::Test do
  let(:sample) { Random.hash }
  let(:experiment_keys) { experiments.keys }
  let(:experiment) { experiment_keys[Random.rand(experiment_keys.size)] }

  before do
    ABSplit.configure do |config|
      config.experiments = experiments
    end
  end

  shared_examples :random_split do
    it 'returns one of the options in one the experiments' do
      expect(%w[optionA optionB]).to include(ABSplit::Test.split(experiment, sample))
    end
  end

  context 'when an experiment YML exist and is used' do
    let(:experiments) do
      YAML.load_file File.join(File.dirname(__FILE__),
                               '..', '..', 'fixtures', 'example.yml')
    end

    include_examples :random_split
  end

  context 'when the experiments are directly specified in the code' do
    let(:experiments) do
      { 'experiment' =>
        { 'algorithm' => 'Md5WeightedSplit',
          'options' =>
          [{ 'name' => 'optionA', 'weight' => 50 },
           { 'name' => 'optionB' }] } }
    end

    include_examples :random_split
  end
end
