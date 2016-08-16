
module TenPin
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class Frame
    MAX_FRAME_ROLLS = 3
    LOWEST_FRAME_SCORE = 0
    MAX_FRAME_ROLL = 10
    MAX_NON_X_ROLLS = 2
    STRIKE_ROLL = 1

    def initialize
      @rolls = []
    end

    def score
      @rolls.inject(0, :+)
    end

    def roll(pins_knocked)
      @rolls << pins_knocked unless scored? || invalid_roll?(pins_knocked)
    end

    def frame_over?
      return true if score == MAX_FRAME_ROLL && @rolls.size == STRIKE_ROLL
      return true if @rolls.size == MAX_NON_X_ROLLS
      false
    end

    def scored?
      return true if score < MAX_FRAME_ROLL && @rolls.size == MAX_NON_X_ROLLS
      return true if @rolls.size == MAX_FRAME_ROLLS
    end

    def valid_roll?(roll)
      roll <= MAX_FRAME_ROLL && roll >= LOWEST_FRAME_SCORE
    end

    def invalid_roll?(roll)
      !valid_roll? roll
    end

    private :valid_roll?, :invalid_roll?, :scored?
  end
end
