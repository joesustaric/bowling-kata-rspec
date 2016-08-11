require 'spec_helper'
require 'ten_pin/frame'

describe TenPin::Frame do

  subject(:new_frame) { TenPin::Frame.new }
  let(:random_non_zero_roll) { (1..10).to_a.sample }
  let(:random_non_zero_non_strike_roll) { (1..9).to_a.sample }
  let(:first_non_strike_non_spare_roll) { 2 }
  let(:second_non_strike_non_spare_roll) { 5 }
  let(:non_strike_non_spare_result) do
    first_non_strike_non_spare_roll + second_non_strike_non_spare_roll
  end
  let(:strike) { 10 }
  # let(:gutter_ball) { 0 }
  # let(:first_roll_spare) { 3 }
  # let(:first_roll_spare) { 7 }

  describe '#score' do

    context 'Given a new frame' do

      it { expect(new_frame.score).to eq 0 }

      context 'when you roll a gutter ball' do
        before { new_frame.roll gutter_ball }

        it { expect(new_frame.score).to eq 0 }
      end

      context 'when we score the first roll' do
        before { new_frame.roll random_non_zero_roll }

        it { expect(new_frame.score).to eq random_non_zero_roll }
      end

      context 'when first roll knocks > 0 < 10' do
        before { new_frame.roll random_non_zero_non_strike_roll }

        it { expect(new_frame.score).to eq random_non_zero_non_strike_roll }
      end

      context 'when two rolls knock < 10' do
        before do
          new_frame.roll first_non_strike_non_spare_roll
          new_frame.roll second_non_strike_non_spare_roll
        end

        it { expect(new_frame.score).to eq non_strike_non_spare_result }
      end

    end

    context 'when strike is rolled' do
      before { new_frame.roll strike }

      it { expect(new_frame.score).to eq strike }
    end

    # context 'when a strike is rolled and 1 bonus roll scored' do
    # end
    # context 'when a strike is rolled and 2 bonus roll scored' do
    # end
    # context 'when you get a spare' do
    # end
    # context 'when an invalid roll happens (roll < 0 or > 10)' do
    # end
  end
end
