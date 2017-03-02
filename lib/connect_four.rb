require_relative 'player'
require_relative 'board'

class ConnectFour
  attr_accessor :player_one, :player_two, :board, :current_player

  def initialize
    @board = Board.new
    @player_one = Player.new
    @player_two = Player.new
    @current_player = [@player_one, @player_two].sample
  end

  def play
    get_players
    pick_colors
    colors_message
    loop do
      turn_message
    get_move
    @board.print_board
    if @board.winner?(@current_player) 
      winner_message 
      break
    end
    switch_players
    end

  end

  def winner_message
    puts "#{@current_player.name} is the winner!"
  end
  
  def turn_message
    puts "#{@current_player.name}: It's your turn"
  end
  

  def get_move
    puts "Enter your move 1-7:"
    move = gets.chomp
    move = move.to_i
    if check_move(move)
      make_move(move)
    end
  end

  def check_move(move)
    if move >= 1 && move <= 7 
      return true
    else 
      raise "That is not a column"
    end
  end

  def make_move(move)
    @board.place_piece(move, @current_player)
  end

  def switch_players
    @current_player == @player_one ? @current_player = @player_two : @current_player = @player_one
  end

  def get_players
    print "Enter first players name: "
    @player_one.name = gets.chomp
    print "Enter second players name: "
    @player_two.name = gets.chomp
  end
  
  def pick_colors
    @player_one.color = ["red", "blue"].sample
    @player_one.color == "red" ? @player_two.color = "blue" : @player_two.color = "red"
  end

  def colors_message
    puts "#{@player_one.name}'s color is #{@player_one.color}"
    puts "#{@player_two.name}'s color is #{@player_two.color}"
  end
end

#x = ConnectFour.new
#x.play
