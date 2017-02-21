class Board 
  attr_reader :grid

  def initialize
    @grid = Array.new(7) { Array.new(6) { nil }}
  end

  def place_piece(col, piece)
    @grid[col-1].each_with_index do |row, index|
      if row == nil
        @grid[col-1][index] = piece 
        break
      elsif index == 5
        raise "This column is already full"
      end
    end
  end
  
  def winner?(piece)
    color = piece.color
    (0..(@grid.length - 1)).each do |col|
      (0..(@grid[0].length - 1)).each do |row|
        if @grid[col][row]
          if @grid[col][row].color == color
            if row < (@grid[0].length - 3)
              if vertical_check(color, col, row) 
                return true
              end
            end
            if col < (@grid.length - 3)
              if horizontal_check(color, col, row)
                return true
              end
            end
            if (col < (@grid.length - 3)) && (row < (@grid.length - 3))
              if diagonal_up_check(color, col, row)
                return true
              end
            end
            if (col < (@grid.length - 3)) && (row >= (@grid.length - 3))
              if diagonal_down_check(color, col, row)
                return true
              end
            end
          end
        end
      end
    end
    return false
  end

  private

  def diagonal_down_check(color, col, row)
    in_a_row = 1
    3.times do |index|
      if @grid[col + index + 1][row - index - 1]
        if @grid[col + index + 1][row - index - 1].color == color
          in_a_row += 1
        end
      end
    end
    if in_a_row == 4
      return true
    else false
    end
  end

  def diagonal_up_check(color, col, row)
    in_a_row = 1
    3.times do |index|
      if @grid[col + index + 1][row + index + 1]
        if @grid[col + index + 1][row + index + 1].color == color
          in_a_row += 1
        end
      end
    end
    if in_a_row == 4
      return true
    else false
    end
 
  end

  def horizontal_check(color, col, row)
    in_a_row = 1
    3.times do |index|
      if @grid[col + index + 1][row]
        if @grid[col + index + 1][row].color == color
          in_a_row += 1
        end
      end
    end
    if in_a_row == 4
      return true
    else false
    end
  end

  def vertical_check(color, col, row)
    in_a_row = 1
    3.times do |index|
      if @grid[col][row + index + 1]
        if @grid[col][row + index + 1].color == color
          in_a_row += 1
        end
      end
    end
    if in_a_row == 4
      return true
    else false
    end
  end
  

end
