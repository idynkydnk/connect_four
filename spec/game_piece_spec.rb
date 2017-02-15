require "game_piece"

describe GamePiece do
  describe ".color" do

    context "color should be black or red" do
      it "is black" do
        piece = GamePiece.new("black")
        expect(piece.color).to eql("black")
      end

      it "is red" do
        piece = GamePiece.new("red")
        expect(piece.color).to eql("red")
      end
    end

    context "color is something other than black or red" do
      it "raises an error" do
        expect{GamePiece.new("white")}.to raise_error(RuntimeError)
      end
    end
  end
end
