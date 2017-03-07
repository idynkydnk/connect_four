class Board 
  attr_accessor :grid

  def initialize
    @grid = Array.new(7) { Array.new(6) { nil }}
  end

  def print_board
    (@grid[0].length - 1).downto(0) do |row|
      @grid.length.times do |col|
        print "|"
        if @grid[col][row] && @grid[col][row].color == "red"
          print "\e[31m#{"\u25cf"}\e[0m" # red circle
        elsif @grid[col][row] && @grid[col][row].color == "blue"
          print "\e[34m#{"\u25cf"}\e[0m" # blue circle
        else print " "
        end
      end
      puts "|"
    end
  end

  def place_piece(col, piece)
    col = check_col(col)
    @grid[col-1].each_with_index do |row, index|
      if row == nil
        @grid[col-1][index] = piece 
        break
      elsif index == 5
        begin
          raise "This column is already full"
        rescue
          puts "Column is full, enter another column"
          col = gets.chomp
          col = col.to_i
          place_piece(col, piece)
        end
      end
    end
  end

  def full_board?
    (0..(@grid.length - 1)).each do |col|
      (0..(@grid[0].length - 1)).each do |row|
        if @grid[col][row] == nil
          return false
        end
      end
    end
    return true
  end

  def check_col(col)
    if col >= 1 && col <= 7 
      return col
    else 
      enter_column
    end
  end

  def enter_column
    puts "Enter a new column: "
    col = gets.chomp
    col = col.to_i
    return check_col(col)
  end

  def winner?(piece)
    color = piece.color
    (0..(@grid.length - 1)).each do |col|
      (0..(@grid[0].length - 1)).each do |row|
        if @grid[col][row] && @grid[col][row].color == color
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
