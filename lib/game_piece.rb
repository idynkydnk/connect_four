class GamePiece
  attr_accessor :color

  def initialize(color)
    if color == "yellow" || color == "red"
      @color = color
    else
      raise "game piece must be either yellow or red"
    end
  end
end
