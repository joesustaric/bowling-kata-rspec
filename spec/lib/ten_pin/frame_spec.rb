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
  let(:spare_roll) { strike - random_non_zero_non_strike_roll }
  let(:first_non_strike_non_spare_roll) { 2 }
  let(:second_non_strike_non_spare_roll) { 3 }
  let(:gutter_ball) { 0 }
  # let(:non_strike_non_spare_result) do
  #   first_non_strike_non_spare_roll + second_non_strike_non_spare_roll
  # end
  # let(:score_plus_random_non_zero_bowl) { strike + random_non_zero_bowl }
  # let(:score_plus_two_random_non_zero_bowl) do
  #   strike + first_non_strike_non_spare_roll +
  #     second_non_strike_non_spare_roll
  # end
  # let(:spare_score) { 10 }
  # let(:spare_plus_bonus_roll_score) { spare_score + random_non_zero_bowl }

  describe '#register_bowl' do

    context 'Given a new game' do

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

  describe '#bonus_mode?' do

    context 'Given a new game' do
      it { expect(new_frame.bonus_mode?).to eq false }
    end

    context 'Given a strike bowl' do
      before { new_frame.register_bowl strike }

      it { expect(new_frame.bonus_mode?).to eq true }
    end

    context 'Given a non strike first bowl' do
      before { new_frame.register_bowl random_non_zero_non_strike_roll }

      it { expect(new_frame.bonus_mode?).to eq false }
    end

    context 'Given a spare frame played' do
      before do
        new_frame.register_bowl random_non_zero_non_strike_roll
        new_frame.register_bowl(max_score - random_non_zero_non_strike_roll)
      end

      it { expect(new_frame.bonus_mode?).to eq true }
    end
  end

  describe '#score' do

    context 'Given a new frame' do
      it { expect(new_frame.score).to eq 0 }

      context 'when we roll a valid first roll' do
        before { new_frame.register_bowl random_non_zero_bowl }

        it { expect(new_frame.score).to eq random_non_zero_bowl }
      end

      context 'when we roll a strike' do
        before { new_frame.register_bowl strike }

        it { expect(new_frame.score).to eq strike }
        it 'does not score any new bowls' do
          new_frame.register_bowl random_non_zero_bowl
          expect(new_frame.score).to eq strike
        end
      end

      context 'when we roll a spare' do
        before do
          new_frame.register_bowl random_non_zero_bowl
          new_frame.register_bowl(max_score - random_non_zero_bowl)
        end

        it { expect(new_frame.score).to eq max_score }
        it 'does not score any new bowls' do
          new_frame.register_bowl random_non_zero_bowl
          expect(new_frame.score).to eq strike
        end
      end

      context 'when we roll a non spare second bowl' do
        let(:score) { 9 }
        before do
          second_bowl = max_score - random_non_zero_non_strike_roll - 1
          new_frame.register_bowl random_non_zero_non_strike_roll
          new_frame.register_bowl second_bowl
        end

        it { expect(new_frame.score).to eq score }

        it 'does not score any new bowls' do
          new_frame.register_bowl random_non_zero_bowl
          expect(new_frame.score).to eq score
        end
      end

      context 'when we roll the worst frame ever (two 0 bowls)' do
        let(:worst_frame_score) { 0 }
        before do
          new_frame.register_bowl gutter_ball
          new_frame.register_bowl gutter_ball
        end

        it { expect(new_frame.score).to eq worst_frame_score }
      end

      context 'when we bowl best frame ever (strike + 2 bonus strike bowls)' do
        let(:best_frame_score) { 30 }
        before do
          new_frame.register_bowl strike
          new_frame.score_bonus strike
          new_frame.score_bonus strike
        end

        it { expect(new_frame.score).to eq best_frame_score }
      end
    end

    context 'Given a strike frame' do
      before { new_frame.register_bowl strike }

      context 'when we score 1 bonus bowl' do
        before { new_frame.score_bonus random_non_zero_bowl }

        it { expect(new_frame.score).to eq(strike + random_non_zero_bowl) }
      end

      context 'when we score 2 bonus bowls' do
        before do
          new_frame.score_bonus random_non_zero_bowl
          new_frame.score_bonus random_non_zero_bowl
        end

        it 'score is correct' do
          score = max_score + (random_non_zero_bowl * 2)
          expect(new_frame.score).to eq(score)
        end
        it 'does not score any more bonus bowls' do
          new_frame.score_bonus random_non_zero_bowl
          expect(new_frame.score).to eq(max_score + (random_non_zero_bowl * 2))
        end
      end
    end

    context 'Given a spare frame' do
      before do
        new_frame.register_bowl random_non_zero_non_strike_roll
        new_frame.register_bowl spare_roll
      end

      context 'when we score 1 bonus bowl' do
        before { new_frame.score_bonus random_non_zero_bowl }

        it 'score is correct' do
          score = max_score + random_non_zero_bowl
          expect(new_frame.score).to eq(score)
        end
        it 'does not score any more bonus bowls' do
          score = max_score + random_non_zero_bowl
          new_frame.score_bonus random_non_zero_bowl
          expect(new_frame.score).to eq(score)
        end
      end
    end

  end

  describe '#frame_over?' do

    context 'Given a new frame' do

      it { expect(new_frame.frame_over?).to eq false }

      context 'when we bowl a strike' do
        before { new_frame.register_bowl strike }

        it { expect(new_frame.frame_over?).to eq false }
      end

      context 'when we score one bonus bowl from a strike frame' do
        before do
          new_frame.register_bowl strike
          new_frame.score_bonus random_non_zero_bowl
        end

        it { expect(new_frame.frame_over?).to eq false }
      end

      context 'when we score two bonus bowls from a strike frame' do
        before do
          new_frame.register_bowl strike
          new_frame.score_bonus random_non_zero_bowl
          new_frame.score_bonus random_non_zero_bowl
        end

        it { expect(new_frame.frame_over?).to eq true }
      end

      context 'when we bowl a non strike first bowl' do
        before { new_frame.register_bowl first_non_strike_non_spare_roll }

        it { expect(new_frame.frame_over?).to eq false }
      end

      context 'when we bowl two non spare bowls' do
        before do
          new_frame.register_bowl first_non_strike_non_spare_roll
          new_frame.register_bowl second_non_strike_non_spare_roll
        end

        it { expect(new_frame.frame_over?).to eq true }
      end

      context 'when we bowl a spare' do
        before do
          new_frame.register_bowl random_non_zero_non_strike_roll
          new_frame.register_bowl spare_roll
        end

        it { expect(new_frame.frame_over?).to eq false }
      end

      context 'when we have scored 1 bonus bowl from a spare frame' do
        before do
          new_frame.register_bowl random_non_zero_non_strike_roll
          new_frame.register_bowl spare_roll
          new_frame.score_bonus random_non_zero_bowl
        end

        it { expect(new_frame.frame_over?).to eq true }
      end
    end

  end

end
