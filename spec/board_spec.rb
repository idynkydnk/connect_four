require "board"

describe Board do
  context "sets a 7x6 grid" do
    it "sets 7 rows" do
      board = Board.new
      expect(board.grid.length).to be(7)
    end

    it "sets 6 columns inside each row" do
      board = Board.new
      board.grid.each do |row|
        expect(row.length).to be(6)
      end
    end
  end

  context "each cell should be nil or a game piece" do
    it "all cells are nil" do
      board = Board.new
      expect(board.grid[0][0]).to be(nil)
      expect(board.grid[2][3]).to be(nil)
      expect(board.grid[6][0]).to be(nil)
    end
  end

  describe ".place_piecee" do
    it "places a piece into a column 1-7" do
      board = Board.new
      object = double("object")
      board.place_piece(1, object)
      expect(board.grid[0][0]).to eql(object)
      expect(board.grid[0][1]).to eql(nil)
    end

    it "places a piece to the second row when first row is occupied" do
      board = Board.new
      object = double("object")
      board.place_piece(1, object)
      board.place_piece(1, object)
      expect(board.grid[0][1]).to eql(object)
    end

    it "places piece in last row" do
      board = Board.new
      object = double("object")
      6.times do
        board.place_piece(1, object)
      end
      expect(board.grid[0][5]).to eql(object)
    end

    it "places piece in last column" do
      board = Board.new
      object = double("object")
      board.place_piece(7, object)
      expect(board.grid[6][0]).to eql(object)
    end

    it "raises an error if column is full" do
      board = Board.new
      object = double("object")
      6.times do
        board.place_piece(1, object)
      end
      expect{ board.place_piece(1, object) }.to raise_error(RuntimeError)
    end
  end


  describe ".winner?" do
    it "returns true with four in a row vertically in first column" do
      board = Board.new
      object = double("object", :color => "black")
      4.times do
        board.place_piece(1, object)
      end
      expect(board.winner?(object)).to be(true) 
    end

    it "returns true with four in a row vertically and up a row" do
      board = Board.new
      black_object = double("black_object", :color => "black")
      red_object = double("red_object", :color => "red")
      board.place_piece(1, black_object)
      4.times do
        board.place_piece(1, red_object)
      end
      expect(board.winner?(red_object)).to be(true) 
    end
    
    it "returns true with four in a row vertically a few columns over" do
      board = Board.new
      black_object = double("black_object", :color => "black")
      red_object = double("red_object", :color => "red")
      board.place_piece(4, red_object)
      board.place_piece(4, red_object)
      4.times do
        board.place_piece(4, black_object)
      end
      expect(board.winner?(black_object)).to be(true) 
    end

    it "returns true with four in a row vertically top right corner" do
      board = Board.new
      black_object = double("black_object", :color => "black")
      red_object = double("red_object", :color => "red")
      board.place_piece(7, red_object)
      board.place_piece(7, red_object)
      4.times do
        board.place_piece(7, black_object)
      end
      expect(board.winner?(black_object)).to be(true) 
    end

    it "returns false with no pieces on the board" do
      board = Board.new
      black_object = double("black_object", :color => "black")
      expect(board.winner?(black_object)).to be(false) 
    end

    it "returns false if the other color has four in a row" do
      board = Board.new
      black_object = double("black_object", :color => "black")
      red_object = double("red_object", :color => "red")
      board.place_piece(6, red_object)
      board.place_piece(6, red_object)
      4.times do
        board.place_piece(6, black_object)
      end
      expect(board.winner?(red_object)).to be(false) 
    end

    it "returns true if four in a row horizontally" do
      board = Board.new
      black_object = double("black_object", :color => "black")
      board.place_piece(1, black_object)
      board.place_piece(2, black_object)
      board.place_piece(3, black_object)
      board.place_piece(4, black_object)
      expect(board.winner?(black_object)).to be(true) 
    end

    it "returns true if four in a row horizontally and up a few rows" do
      board = Board.new
      black_object = double("black_object", :color => "black")
      red_object = double("red_object", :color => "red")
      3.times do
        board.place_piece(1, black_object)
        board.place_piece(2, black_object)
        board.place_piece(3, black_object)
        board.place_piece(4, black_object)
      end
      board.place_piece(1, red_object)
      board.place_piece(2, red_object)
      board.place_piece(3, red_object)
      board.place_piece(4, red_object)
    
      expect(board.winner?(red_object)).to be(true) 
    end

    it "returns true if four in a row horizontally and up and over a little" do
      board = Board.new
      black_object = double("black_object", :color => "black")
      red_object = double("red_object", :color => "red")
      1.times do
        board.place_piece(3, black_object)
        board.place_piece(4, black_object)
        board.place_piece(5, black_object)
        board.place_piece(6, black_object)
      end
      board.place_piece(3, red_object)
      board.place_piece(4, red_object)
      board.place_piece(5, red_object)
      board.place_piece(6, red_object)
    
      expect(board.winner?(red_object)).to be(true) 
    end

    it "returns true if four in a row horizontally and up and over a lot" do
      board = Board.new
      black_object = double("black_object", :color => "black")
      red_object = double("red_object", :color => "red")
      5.times do
        board.place_piece(4, black_object)
        board.place_piece(5, black_object)
        board.place_piece(6, black_object)
        board.place_piece(7, black_object)
      end
      board.place_piece(4, red_object)
      board.place_piece(5, red_object)
      board.place_piece(6, red_object)
      board.place_piece(7, red_object)
    
      expect(board.winner?(red_object)).to be(true) 
    end

    it "returns true if four in a row diagonally up" do
      board = Board.new
      black_object = double("black_object", :color => "black")
      red_object = double("red_object", :color => "red")
      board.place_piece(2, red_object)
      2.times { board.place_piece(3, red_object) }
      3.times { board.place_piece(4, red_object) }
      board.place_piece(1, black_object)
      board.place_piece(2, black_object)
      board.place_piece(3, black_object)
      board.place_piece(4, black_object)
    
      expect(board.winner?(black_object)).to be(true) 
    end

    it "returns true if four in a row diagonally up and over a little" do
      board = Board.new
      black_object = double("black_object", :color => "black")
      red_object = double("red_object", :color => "red")
      2.times { board.place_piece(4, red_object) }
      3.times { board.place_piece(5, red_object) }
      4.times { board.place_piece(6, red_object) }
      5.times { board.place_piece(7, red_object) }
      board.place_piece(4, black_object)
      board.place_piece(5, black_object)
      board.place_piece(6, black_object)
      board.place_piece(7, black_object)
    
      expect(board.winner?(black_object)).to be(true) 
    end

    it "returns true if four in a row diagonally down" do
      board = Board.new
      black_object = double("black_object", :color => "black")
      red_object = double("red_object", :color => "red")
      5.times { board.place_piece(1, red_object) }
      4.times { board.place_piece(2, red_object) }
      3.times { board.place_piece(3, red_object) }
      2.times { board.place_piece(4, red_object) }
      board.place_piece(1, black_object)
      board.place_piece(2, black_object)
      board.place_piece(3, black_object)
      board.place_piece(4, black_object)
    
      expect(board.winner?(black_object)).to be(true) 
    end

    it "returns true if four in a row diagonally down and over a little" do
      board = Board.new
      black_object = double("black_object", :color => "black")
      red_object = double("red_object", :color => "red")
      5.times { board.place_piece(4, red_object) }
      4.times { board.place_piece(5, red_object) }
      3.times { board.place_piece(6, red_object) }
      2.times { board.place_piece(7, red_object) }
      board.place_piece(4, black_object)
      board.place_piece(5, black_object)
      board.place_piece(6, black_object)
      board.place_piece(7, black_object)
    
      expect(board.winner?(black_object)).to be(true) 
    end



   
  end
end
