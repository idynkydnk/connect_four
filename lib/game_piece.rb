class GamePiece
  attr_accessor :color

  def initialize(color)
    if color == "black" || color == "red"
      @color = color
    else
      raise "game piece must be either black or red"
    end
  end
end
