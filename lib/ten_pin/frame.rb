
module TenPin
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class Frame
    MAX_FRAME_SCORE = 10
    MIN_FRAME_SCORE = 0
    STRIKE_INDEX = 0
    SPARE_BOWLS = 2

    def initialize
      @bowls = []
      @bonus_bowls = []
    end

    def score
      @bowls.inject(0, :+) + @bonus_bowls.inject(0, :+)
    end

    def bonus?
      strike? || spare?
    end

    def register_bowl(bowl)
      return false unless valid_bowl? bowl
      @bowls << bowl
      true
    end

    def score_bonus(bowl)
      return false unless bowled_pins_between_zero_and_ten? bowl
      @bonus_bowls << bowl
      true
    end

    def valid_bowl?(bowl)
      bowl.is_a?(Integer) && valid_frame_bowl?(bowl)
    end

    def valid_frame_bowl?(bowl)
      available_score_left = MAX_FRAME_SCORE - score
      bowl <= available_score_left && bowled_pins_between_zero_and_ten?(bowl)
    end

    def bowled_pins_between_zero_and_ten?(bowl)
      bowl.is_a?(Integer) && bowl >= MIN_FRAME_SCORE && bowl <= MAX_FRAME_SCORE
    end

    def strike?
      @bowls[STRIKE_INDEX] == MAX_FRAME_SCORE
    end

    def spare?
      @bowls.size == SPARE_BOWLS && score == MAX_FRAME_SCORE
    end
    #
    # def frame_over?
    #   return true if score == MAX_FRAME_ROLL && @rolls.size == STRIKE_ROLL
    #   return true if @rolls.size == MAX_NON_X_ROLLS
    #   false
    # end
    #
    # def scored?
    #   return true if score < MAX_FRAME_ROLL && @rolls.size == MAX_NON_X_ROLLS
    #   return true if @rolls.size == MAX_FRAME_ROLLS
    #   false
    # end
    #
    # def valid_roll?(roll)
    #   roll <= MAX_FRAME_ROLL && roll >= LOWEST_FRAME_SCORE
    # end
    #
    # def invalid_roll?(roll)
    #   !valid_roll? roll
    # end
    #
    private :valid_bowl?, :bowled_pins_between_zero_and_ten?, :strike?
    private :valid_frame_bowl?
  end
end
