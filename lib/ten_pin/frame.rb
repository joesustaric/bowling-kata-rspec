
module TenPin
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class Frame
    # attr_reader :bowls, :bonus_bowls

    MAX_FRAME_SCORE = 10
    MIN_FRAME_SCORE = 0
    FIRST_BOWL = 0
    SECOND_BOWL = 1
    BONUS_BOWLS = 3
    TWO_BOWLS = 2

    def initialize
      @bowls = []
    end

    def score
      @bowls.inject(0, :+)
    end

    def frame_over?
      bonus_scored? ||
        two_bowls_completed_no_bonus?
    end

    def frame_not_over?
      !frame_over?
    end

    def regular_bowls_complete?
      strike? || two_bowls_completed?
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
      return false unless valid_bonus_bowl? bowl
      return false unless bonus_mode?
      @bowls << bowl unless bonus_scored?
      true
    end

    def valid_bowl?(bowl)
      bowl.is_a?(Integer) && valid_frame_bowl?(bowl)
    end

    def valid_bonus_bowl?(bowl)
      bowl.is_a?(Integer) && bowled_pins_between_zero_and_ten?(bowl)
    end

    def valid_frame_bowl?(bowl)
      bowl <= available_score_left &&
        bowled_pins_between_zero_and_ten?(bowl)
    end

    def available_score_left
      MAX_FRAME_SCORE - score
    end

    def bowled_pins_between_zero_and_ten?(bowl)
      bowl >= MIN_FRAME_SCORE && bowl <= MAX_FRAME_SCORE
    end

    def strike?
      return true if @bowls.size >= 1 && @bowls[FIRST_BOWL] == MAX_FRAME_SCORE
      false
    end

    def spare?
      return true if @bowls.size >= 2 &&
                     @bowls[FIRST_BOWL] + @bowls[SECOND_BOWL] == MAX_FRAME_SCORE
      false
    end

    def two_bowls_completed?
      @bowls.size >= TWO_BOWLS
    end

    def two_bowls_completed_no_bonus?
      two_bowls_completed? && no_bonus_mode?
    end

    def max_frame_scored?
      score == MAX_FRAME_SCORE
    end

    def bonus_scored?
      bonus_mode? && @bowls.size == BONUS_BOWLS
    end

    private :no_bonus_mode?, :max_frame_scored?
    private :valid_bowl?, :bowled_pins_between_zero_and_ten?
    private :valid_frame_bowl?, :available_score_left, :strike?, :spare?
    private :bonus_scored?, :two_bowls_completed_no_bonus?
  end
end
