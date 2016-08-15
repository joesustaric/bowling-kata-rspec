
module TenPin
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class Frame
    attr_accessor :rolls

    MAX_FRAME_ROLLS = 3
    LOWEST_FRAME_SCORE = 0
    MAX_FRAME_SCORE = 10
    MAX_NON_X_ROLLS = 2

    def initialize
      @rolls = []
    end

    def score
      @rolls.inject(0, :+)
    end

    def roll(pins_knocked)
      @rolls << pins_knocked unless scored? || invalid_roll?(pins_knocked)
    end

    def scored?
      return true if score < MAX_FRAME_SCORE && @rolls.size == MAX_NON_X_ROLLS
      return true if @rolls.size == MAX_FRAME_ROLLS
    end

    def valid_roll?(roll)
      return true unless roll > MAX_FRAME_SCORE || roll < LOWEST_FRAME_SCORE
    end

    def invalid_roll?(roll)
      !valid_roll? roll
    end
  end
end
