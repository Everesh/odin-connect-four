require_relative '../lib/connect_four'

describe ConnectFour do
  subject(:game) { described_class.new }

  describe '#initialize' do
    it 'creates a instace variable called board' do
      expect(game.instance_variable_get(:@board)).not_to be_nil
    end

    describe 'board' do
      it 'has a attr_reader method' do
        expect(game).to respond_to(:board)
      end

      it 'has a private attr_reader method' do
        expect(game.private_methods).to include(:board=)
      end

      it 'is an array' do
        expect(game.board).to be_an Array
      end

      it "has BOARD_HEIGHT rows" do
        expect(described_class::BOARD_HEIGHT).to eql(game.board.length)
      end

      it "has BOARD_WIDTH columns" do
        expect(game.board).to all(have_attributes(length: described_class::BOARD_WIDTH))
      end
    end

    it 'creates a instance variable called player' do
      expect(game.instance_variable_get(:@player)).not_to be_nil
    end

    describe 'player' do
      it 'has attr_reader method' do
        expect(game).not_to respond_to(:player)
      end

      it 'has a private attr_accessor method' do
        expect(game.private_methods).to include(:player).and include(:player=)
      end

      it 'is an integer' do
        expect(game.instance_variable_get(:@player)).to be_an Integer
      end

      it 'is set to 1' do
        expect(game.instance_variable_get(:@player)).to be(1)
      end
    end
  end

end
