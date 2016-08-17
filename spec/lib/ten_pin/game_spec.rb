require 'spec_helper'
require 'ten_pin/game'

describe TenPin::Game do

  subject(:new_game) { TenPin::Game.new }

  let(:perfect_game) { [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10] }
  let(:perfect_game_score) { 300 }
  # let(:worst_game_ever) { [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ] }
  # let(:perfect_game_score) { 0 }
  # let(:random_game) { 10, 1, 2, 5, 2, 5, 5, 3, 0, 0, 0, 4, 4, 9, 1 , 9,0,10,10,10 }
  # let(:random_game_score) { 13 + 3 + 7 + 13 + 3 + 0 + 8 + 19 + 9 + 30 }
  #
  describe '#bowl' do
    context 'when we bowl a perfect game' do
      before { perfect_game.each { |roll| new_game.bowl roll } }

      it { expect(new_game.score).to eq perfect_game_score }
    end
  end
end
