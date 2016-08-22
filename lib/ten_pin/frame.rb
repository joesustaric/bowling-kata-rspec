
module TenPin
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class Frame
    attr_reader :bowls, :bonus_bowls

    MAX_FRAME_SCORE = 10
    MIN_FRAME_SCORE = 0
    STRIKE_BOWL = 1
    SPARE_BOWLS = 2
    STRIKE_BONUS_BOWLS = 2
    SPARE_BONUS_BOWLS = 1
    MAX_FRAME_BOWLS = 2

    def initialize
      @bowls = []
      @bonus_bowls = []
    end

    def score
      frame_score + bonus_score
    end

    def frame_over?
      strike_bonus_scored? ||
      spare_bonus_scored? ||
      two_bowls_completed_no_bonus?
    end

    def frame_score
      @bowls.inject(0, :+)
    end

    def bonus_score
      @bonus_bowls.inject(0, :+)
    end

    def bonus_mode?
      strike? || spare?
    end

    def no_bonus_mode?
      !bonus_mode?
    end

    def register_bowl(bowl)
      return false unless valid_bowl? bowl
      @bowls << bowl
      true
    end

    def score_bonus(bowl)
      return false unless bowled_pins_between_zero_and_ten? bowl
      return false unless bonus_mode?
      @bonus_bowls << bowl unless bonus_scored?
      true
    end

    def valid_bowl?(bowl)
      bowl.is_a?(Integer) && valid_frame_bowl?(bowl)
    end

    def valid_frame_bowl?(bowl)
      bowl <= available_score_left &&
        bowled_pins_between_zero_and_ten?(bowl) &&
        @bowls.size < MAX_FRAME_BOWLS
    end

    def available_score_left
      MAX_FRAME_SCORE - score
    end

    def bowled_pins_between_zero_and_ten?(bowl)
      bowl >= MIN_FRAME_SCORE &&
        bowl <= MAX_FRAME_SCORE
    end

    def strike?
      @bowls.size == STRIKE_BOWL && max_frame_scored?
    end

    def spare?
      @bowls.size == SPARE_BOWLS && max_frame_scored?
    end

    def two_bowls_completed_no_bonus?
      @bowls.size == MAX_FRAME_BOWLS && no_bonus_mode?
    end

    def max_frame_scored?
      frame_score == MAX_FRAME_SCORE
    end

    def bonus_scored?
      strike_bonus_scored? || spare_bonus_scored?
    end

    def strike_bonus_scored?
      strike? && @bonus_bowls.size == STRIKE_BONUS_BOWLS
    end

    def spare_bonus_scored?
      spare? && @bonus_bowls.size == SPARE_BONUS_BOWLS
    end

    private :frame_score, :bonus_score, :no_bonus_mode?, :max_frame_scored?
    private :valid_bowl?, :bowled_pins_between_zero_and_ten?
    private :valid_frame_bowl?, :available_score_left, :strike?, :spare?
    private :spare_bonus_scored?, :strike_bonus_scored?, :bonus_scored?
    private :two_bowls_completed_no_bonus?
  end
end
