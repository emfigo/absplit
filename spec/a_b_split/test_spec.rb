# frozen_string_literal: true
require 'spec_helper'

describe ABSplit::Test do
  let(:x) { 'testa123' }

  describe '.split' do
    context 'when no experiment file is specified' do
      it 'raises a NoValidExperiment error' do
        expect { described_class.split('experiment', x) }
          .to raise_error(ABSplit::NoValidExperiment)
      end
    end

    context 'when an experiment file is specified' do
      before do
        ABSplit.configure do |config|
          config.experiments = experiment
        end
      end

      context 'and an algorithm is specified' do
        context 'and the algorithm is valid' do
          let(:experiment) do
            { 'experiment' =>
                               { 'algorithm' => 'HeavisideWeightedSplit',
                                 'options' =>
                                   [{ 'name' => 1, 'weight' => 50 },
                                    { 'name' => 2 }] } }
          end

          it 'splits the experiment with the function specified by the user' do
            expect(ABSplit::Functions::HeavisideWeightedSplit)
              .to receive(:value_for)
              .with(x, *experiment['experiment']['options'])

            described_class.split('experiment', x)
          end
        end

        context 'and the algorithm is nil' do
          let(:experiment) do
            { 'experiment' =>
                               { 'options' =>
                                   [{ 'name' => 1, 'weight' => 50 },
                                    { 'name' => 2 }] } }
          end

          it 'splits the experiment with the default function' do
            expect(ABSplit::Functions::WeightedSplit)
              .to receive(:value_for)
              .with(x, *experiment['experiment']['options'])

            described_class.split('experiment', x)
          end
        end

        context 'and the algorithm is not valid' do
          let(:experiment) do
            { 'experiment' =>
                               { 'algorithm' => 'non_valid',
                                 'options' =>
                                   [{ 'name' => 1, 'weight' => 50 },
                                    { 'name' => 2 }] } }
          end

          it 'raises a NoValidExperiment error' do
            expect { described_class.split('experiment', x) }
              .to raise_error(ABSplit::NoValidExperiment)
          end
        end
      end

      context 'and no algorithm is specified' do
        let(:experiment) do
          { 'experiment' =>
                             [{ 'name' => 'optiona', 'weight' => 50 },
                              { 'name' => 'optionb' }] }
        end

        it 'splits the experiment with the default function' do
          expect(ABSplit::Functions::WeightedSplit)
            .to receive(:value_for)
            .with(x, *experiment['experiment'])

          described_class.split('experiment', x)
        end
      end
    end
  end
end
