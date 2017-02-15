require "board"

describe Board do
  context "sets a 7x6 grid" do
    it "sets 7 rows" do
      board = Board.new
      expect(board.grid.length).to be(7)
    end
  end
end
