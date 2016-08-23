require 'spec_helper'
require 'ten_pin/game'

describe TenPin::Game do

  subject(:new_game) { TenPin::Game.new }

  describe '#score' do

    describe 'Given a new game' do

      context 'when we bowl a perfect game' do
        let(:perfect_game) { [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10] }
        let(:perfect_game_score) { 300 }
        before { perfect_game.each { |bowl| new_game.bowl_ball bowl } }

        it { expect(new_game.score).to eq perfect_game_score }
      end

      context 'when we bowl a game with all gutter balls' do
        let(:worst_game_ever) { [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
        let(:perfect_game_score) { 0 }
        before { worst_game_ever.each { |bowl| new_game.bowl_ball bowl } }

        it { expect(new_game.score).to eq perfect_game_score }
      end

      context 'when we bowl a game with no strikes or spares' do
        let(:game_bowls) { [2, 3, 1, 2, 6, 0, 9, 0, 1, 0, 0, 0, 3, 3, 4, 4, 2, 2, 1, 8] }
        let(:game_score) { game_bowls.inject(0, :+) }
        before { game_bowls.each { |bowl| new_game.bowl_ball bowl } }

        it { expect(new_game.score).to eq game_score }
      end

      context 'when we bowl a game with all spares' do
        let(:game_bowls) { [7, 3, 5, 5, 9, 1, 2, 8, 4, 6, 6, 4, 3, 7, 1, 9, 9, 1, 9, 1, 10] }
        let(:game_score) { 158 }
        before { game_bowls.each { |bowl| new_game.bowl_ball bowl } }

        it { expect(new_game.score).to eq game_score }
      end

      context 'when we bowl a game with mixed spares and strikes' do
        let(:game_bowls) { [10, 3, 2, 4, 5, 10, 10, 1, 0, 0, 9, 7, 0, 10, 9, 0] }
        let(:game_score) { 106 }

        before { game_bowls.each { |bowl| new_game.bowl_ball bowl } }

        it { expect(new_game.score).to eq game_score }
      end

      context 'when we bowl some invalid bowls' do
        let(:game_bowls) { [10, 3, 'foo', 2, 4, 5, 10, 10, 1, 0, -62, 0, 9, 7, 0, 10, 9, 0, 99] }
        let(:game_score) { 106 }

        before { game_bowls.each { |bowl| new_game.bowl_ball bowl } }

        it 'ignores them' do
          expect(new_game.score).to eq game_score
        end
      end
    end
  end

end
