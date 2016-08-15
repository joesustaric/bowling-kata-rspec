
module TenPin
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class Frame
    attr_accessor :rolls

    MAX_FRAME_ROLLS = 3
    LOWEST_POSS_ROLL = 0
    HIGHEST_POSS_ROLL = 10

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
      return true if @rolls.size == MAX_FRAME_ROLLS
    end

    def invalid_roll?(roll)
      return false unless roll > HIGHEST_POSS_ROLL || roll < LOWEST_POSS_ROLL
      true
    end
  end
end
