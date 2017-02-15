class Board 
  attr_reader :grid

  def initialize
    @grid = Array.new(7) { Array.new(6) { nil }}
  end
end
