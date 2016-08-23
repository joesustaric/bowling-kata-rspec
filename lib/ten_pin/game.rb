require 'ten_pin/game'

module TenPin
  # Class Comment TODO
  class Game
    START_FRAME_INDEX = 0
    MAX_FRAMES_PER_GAME = 10
    NEXT_INDEX = 1

    def initialize
      @frames = []
      MAX_FRAMES_PER_GAME.times { @frames << TenPin::Frame.new }
      @index_of_frame_in_play = START_FRAME_INDEX
      @frame_in_play = @frames[@index_of_frame_in_play]
    end

    def bowl_ball(bowl)
      unless game_over?
        @frame_in_play.register_bowl bowl
        add_bowl_to_any_bonus_frames bowl
        move_to_next_frame if @frame_in_play.regular_bowls_complete?
      end
    end

    def score
      @frames.inject(0) { |a, e| a + e.score }
    end

    def last_frame?
      @frame_in_play.equal? @frames.last
    end

    def game_over?
      last_frame? && @frames.last.frame_over?
    end

    def move_to_next_frame
      unless last_frame?
        @index_of_frame_in_play += NEXT_INDEX
        @frame_in_play = @frames[@index_of_frame_in_play]
      end
    end

    def add_bowl_to_any_bonus_frames(bowl)
      @frames.each { |f| f.score_bonus bowl }
    end
  end
end
