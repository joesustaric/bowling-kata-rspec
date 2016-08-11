
module TenPin
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class Frame
    attr_accessor :rolls

    def initialize
      @rolls = []
    end

    def score
      @rolls.inject(0, :+)
    end

    def roll(pins_knocked)
      @rolls << pins_knocked
    end
  end
end