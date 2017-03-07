require "connect_four"

describe ConnectFour do
  context "a new game starts" do
    game = ConnectFour.new
    game.player_one.name = "Kyle"
    game.player_two.name = "Lisa"

    it "sets players to Player objects" do
      expect(game.player_one.name).to eql("Kyle") 
      expect(game.player_two.name).to eql("Lisa") 
    end

    describe ".switch_players" do
      it "switches current player from player one to two" do
        game.instance_variable_set(:@current_player, @player_one)
        game.switch_players
        expect(@current_player).to eql(@player_two)
      end 
    end

    describe ".pick_colors" do
      it "picks red or blue for player one" do
        game.pick_colors
        expect(["red", "blue"]).to include(game.player_one.color)
      end

      it "picks red or blue for player two" do
        game.pick_colors
        expect(["red", "blue"]).to include(game.player_two.color)
      end
    end
  end

  context "colors are set" do
    game = ConnectFour.new
    game.player_one.name = "Kyle"
    game.player_one.color = "red"
    game.player_two.name = "Lisa"
    game.player_two.color = "blue"
    game.instance_variable_set(:@current_player, @player_one)

    describe ".color_message" do
      it "lets the players know their color" do
        expect { game.colors_message }.to output("Kyle's color is red\nLisa's color is blue\n\n").to_stdout
      end
    end
  end

  context "working with board instance" do
    describe ".make_move" do
      game = ConnectFour.new
      game.player_one.name = "Kyle"
      game.player_two.name = "Lisa"
      game.current_player.color = "red"
      game.make_move(1)

      it "should be able to place piece from move" do
        expect(game.board.grid[0][0]).to eql(game.current_player)
      end

      it "should be able to print the board with new piece" do
        expect { game.board.print_board }.to output("| | | | | | | |\n| | | | | | | |\n| | | | | | | |\n| | | | | | | |\n| | | | | | | |\n|\e[31m#{"\u25cf"}\e[0m| | | | | | |\n").to_stdout
      end
    end
  end
end
