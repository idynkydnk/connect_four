require 'player'
describe Player do
  context "should have a name and know its turn" do
    it "has a name" do
      player = Player.new
      player.name = "Kyle"
      expect(player.name).to eql("Kyle")
    end
  end
end
