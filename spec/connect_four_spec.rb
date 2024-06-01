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
  end

end
