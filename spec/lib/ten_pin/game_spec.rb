require 'spec_helper'
require 'ten_pin/game'

describe TenPin::Game do

  subject(:new_game) { TenPin::Game.new }

  # let(:random_game) { 10, 1, 2, 5, 2, 5, 5, 3, 0, 0, 0, 4, 4, 9, 1 , 9,0,10,10,10 }
  # let(:random_game_score) { 13 + 3 + 7 + 13 + 3 + 0 + 8 + 19 + 9 + 30 }

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

      end

      context 'when we bowl a game with all spares' do

      end

      context 'when we bowl a game with mixed spares and strikes' do

      end

      context 'when we bowl some invalid bowls' do

      end
    end
  end

end
