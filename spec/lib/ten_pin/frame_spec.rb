require 'spec_helper'
require 'ten_pin/frame'

describe TenPin::Frame do

  subject(:new_frame) { TenPin::Frame.new }

  let(:gutter_ball) { 0 }
  let(:random_non_zero_roll) { (1..10).to_a.sample }
  let(:random_non_zero_non_strike_roll) { (1..9).to_a.sample }
  let(:first_non_strike_non_spare_roll) { 2 }
  let(:second_non_strike_non_spare_roll) { 3 }
  let(:non_strike_non_spare_result) do
    first_non_strike_non_spare_roll + second_non_strike_non_spare_roll
  end
  let(:strike) { 10 }
  let(:score_plus_random_non_zero_roll) { strike + random_non_zero_roll }
  let(:score_plus_two_random_non_zero_roll) do
    strike + first_non_strike_non_spare_roll +
      second_non_strike_non_spare_roll
  end
  let(:spare_roll) { strike - random_non_zero_roll }
  let(:spare_score) { 10 }
  let(:spare_plus_bonus_roll_score) { spare_score + random_non_zero_roll }
  let(:invalid_roll) { [-23, 12].sample }

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

        it 'does not register any more rolls' do
          new_frame.roll random_non_zero_roll
          expect(new_frame.score).to eq non_strike_non_spare_result
        end
      end
    end

    context 'when strike is rolled' do
      before { new_frame.roll strike }

      it { expect(new_frame.score).to eq strike }

      context 'when the first bonus is scored' do
        before { new_frame.roll random_non_zero_roll }

        it { expect(new_frame.score).to eq score_plus_random_non_zero_roll }
      end

      context 'when the second bonus is scored' do
        before do
          new_frame.roll first_non_strike_non_spare_roll
          new_frame.roll second_non_strike_non_spare_roll
        end

        it { expect(new_frame.score).to eq score_plus_two_random_non_zero_roll }
      end

      context 'when non strike frame has been scored' do
        before do
          new_frame.roll first_non_strike_non_spare_roll
          new_frame.roll second_non_strike_non_spare_roll
        end

        it 'does not register any more rolls to the score' do
          new_frame.roll random_non_zero_roll
          expect(new_frame.score).to eq score_plus_two_random_non_zero_roll
        end
      end
    end

    context 'when you get a spare' do
      before do
        new_frame.roll random_non_zero_roll
        new_frame.roll spare_roll
      end

      it { expect(new_frame.score).to eq spare_score }

      context 'when the frame has been scored' do
        before { new_frame.roll random_non_zero_roll }

        it { expect(new_frame.score).to eq spare_plus_bonus_roll_score }

        it 'does not register any more rolls to the score' do
          new_frame.roll random_non_zero_non_strike_roll
          expect(new_frame.score).to eq spare_plus_bonus_roll_score
        end
      end
    end

    context 'when an invalid roll happens (roll < 0 or > 10)' do
      before { new_frame.roll invalid_roll }

      it 'does not register the invalid roll' do
        expect(new_frame.score).to eq 0
      end
    end
  end
end
