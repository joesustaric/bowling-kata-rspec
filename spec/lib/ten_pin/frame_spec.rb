require 'spec_helper'
require 'ten_pin/frame'

describe TenPin::Frame do

  subject(:new_frame) { TenPin::Frame.new }

  let(:new_game_score) { 0 }
  let(:random_non_zero_bowl) { (1..10).to_a.sample }
  let(:random_invalid_bowl) { [-23, -1, 12, 274, 'Foo'].sample }
  let(:max_score) { 10 }
  let(:strike) { 10 }
  let(:random_non_zero_non_strike_roll) { (1..9).to_a.sample }
  # let(:gutter_ball) { 0 }
  # let(:first_non_strike_non_spare_roll) { 2 }
  # let(:second_non_strike_non_spare_roll) { 3 }
  # let(:non_strike_non_spare_result) do
  #   first_non_strike_non_spare_roll + second_non_strike_non_spare_roll
  # end
  # let(:score_plus_random_non_zero_bowl) { strike + random_non_zero_bowl }
  # let(:score_plus_two_random_non_zero_bowl) do
  #   strike + first_non_strike_non_spare_roll +
  #     second_non_strike_non_spare_roll
  # end
  # let(:spare_roll) { strike - random_non_zero_bowl }
  # let(:spare_score) { 10 }
  # let(:spare_plus_bonus_roll_score) { spare_score + random_non_zero_bowl }

  describe '#register_bowl' do

    context 'Given a new game' do
      it { expect(new_frame.score).to eq 0 }

      context 'when we register a valid bowl' do
        before { expect(new_frame.register_bowl(random_non_zero_bowl)).to eq true }

        it { expect(new_frame.score).to eq random_non_zero_bowl }
      end

      context 'when we register a invalid bowl' do
        it { expect(new_frame.register_bowl(random_invalid_bowl)).to eq false }
      end
    end

    context 'Given a non zero non strike first bowl' do
      before { expect(new_frame.register_bowl(random_non_zero_bowl)).to eq true }

      context 'when we try to register a roll that is > 10' do
        before do
          invalid_bowl = max_score - random_non_zero_bowl + 1
          expect(new_frame.register_bowl(invalid_bowl)).to eq false
        end

        it 'does not register the bowl' do
          expect(new_frame.score).to eq random_non_zero_bowl
        end
      end
    end
  end

  describe '#bonus?' do

    context 'Given a new game' do
      it { expect(new_frame.bonus?).to eq false }
    end

    context 'Given a strike bowl' do
      before { new_frame.register_bowl strike }

      it { expect(new_frame.bonus?).to eq true }
    end

    context 'Given a non strike first bowl' do
      before { new_frame.register_bowl random_non_zero_non_strike_roll }

      it { expect(new_frame.bonus?).to eq false }
    end

    context 'Given a spare frame played' do
      before do
        new_frame.register_bowl random_non_zero_non_strike_roll
        new_frame.register_bowl(strike - random_non_zero_non_strike_roll)
      end

      it { expect(new_frame.bonus?).to eq true }
    end
  end
end
