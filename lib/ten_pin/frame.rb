
module TenPin
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class Frame
    # MAX_FRAME_ROLLS = 3
    # LOWEST_FRAME_SCORE = 0
    MAX_FRAME_SCORE = 10
    MIN_FRAME_SCORE = 0
    # MAX_NON_X_ROLLS = 2
    # STRIKE_ROLL = 1

    def initialize
      @bowls = []
    end

    def score
      @bowls.inject(0, :+)
    end

    def register_bowl(bowl)
      return false unless valid_bowl? bowl
      @bowls << bowl
      true
      # @rolls << pins_knocked unless scored? || invalid_roll?(pins_knocked)
    end

    def valid_bowl?(bowl)
      bowl.is_a?(Integer) && valid_frame_bowl?(bowl)
    end

    def valid_frame_bowl?(bowl)
      available_score_left = MAX_FRAME_SCORE - score
      bowl <= available_score_left && bowled_pins_between_zero_and_ten?(bowl)
    end

    def bowled_pins_between_zero_and_ten?(bowl)
      bowl >= MIN_FRAME_SCORE && bowl <= MAX_FRAME_SCORE
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
    private :valid_bowl?, :bowled_pins_between_zero_and_ten?
  end
end
