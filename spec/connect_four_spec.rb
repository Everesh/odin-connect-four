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

      it "is filled with ' '" do
        expect(game.board.flatten.all?(' ')).to be true
      end
    end

    it 'creates a instance variable called player' do
      expect(game.instance_variable_get(:@player)).not_to be_nil
    end

    describe 'player' do
      it 'has attr_reader method' do
        expect(game).to respond_to(:player)
      end

      it 'has a private attr_writer method' do
        expect(game.private_methods).to include(:player=)
      end

      it 'is an integer' do
        expect(game.instance_variable_get(:@player)).to be_an Integer
      end

      it 'is set to 1' do
        expect(game.instance_variable_get(:@player)).to be(1)
      end
    end
  end

  describe '#play' do
    describe 'of 7 turns' do
      before do
        allow(game).to receive(:print_welcome)
        allow(game).to receive(:apply_move)
        allow(game).to receive(:get_input).and_return(1, 2, 1, 3, 1, 5, 1)
        allow(game).to receive(:print_state)
        allow(game).to receive(:winner?).and_return(false, false, false, false, false, false, true)
        allow(game).to receive(:print_conclusion)
        allow(game).to receive(:player=).and_call_original
        game.play
      end

      it 'prints welcome message' do
        expect(game).to have_received(:print_welcome)
      end

      it 'asks for inputs' do
        expect(game).to have_received(:get_input).at_least(:twice)
      end

      it 'applies moves' do
        expect(game).to have_received(:apply_move).at_least(:twice)
      end

      it 'prints states' do
        expect(game).to have_received(:print_state).at_least(:twice)
      end

      it 'asks about winner' do
        expect(game).to have_received(:winner?).at_least(:twice)
      end

      it 'switched players' do
        expect(game).to have_received(:player=).with(2).at_least(:once)
        expect(game).to have_received(:player=).with(1).at_least(:once)
      end
    end
  end

  describe '#apply_move' do
    before do
      allow(game).to receive(:print_welcome)
      allow(game).to receive(:get_input).and_return(0)
      allow(game).to receive(:print_state)
      allow(game).to receive(:print_conclusion)
      allow(game).to receive(:winner?).and_return(true)
    end

    it 'applies move correctly if player is 1' do
      game.play
      expect(game.board).to eql([[' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                 [' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                 [' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                 [' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                 [' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                 [described_class::PLAYER_ONE, ' ', ' ', ' ', ' ', ' ', ' ']])
    end

    it 'applies move correctly if player is 2' do
      allow(game).to receive(:player).and_return(2)
      game.play
      expect(game.board).to eql([[' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                 [' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                 [' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                 [' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                 [' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                 [described_class::PLAYER_TWO, ' ', ' ', ' ', ' ', ' ', ' ']])
    end

    it 'applies moves in column correctly' do
        allow(game).to receive(:player).and_return(1)
        game.play
        allow(game).to receive(:player).and_return(2)
        game.play
        allow(game).to receive(:player).and_return(1)
        game.play
        expect(game.board).to eql([[' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                   [' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                   [' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                   [described_class::PLAYER_ONE, ' ', ' ', ' ', ' ', ' ', ' '],
                                   [described_class::PLAYER_TWO, ' ', ' ', ' ', ' ', ' ', ' '],
                                   [described_class::PLAYER_ONE, ' ', ' ', ' ', ' ', ' ', ' ']])
    end
    it 'applies moves in row correctly' do
        allow(game).to receive(:player).and_return(1)
        allow(game).to receive(:get_input).and_return(0)
        game.play
        allow(game).to receive(:player).and_return(2)
        allow(game).to receive(:get_input).and_return(1)
        game.play
        allow(game).to receive(:player).and_return(1)
        allow(game).to receive(:get_input).and_return(2)
        game.play
        expect(game.board).to eql([[' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                   [' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                   [' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                   [' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                   [' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                   [described_class::PLAYER_ONE, described_class::PLAYER_TWO,
                                    described_class::PLAYER_ONE, ' ', ' ', ' ', ' ']])
    end
  end
end