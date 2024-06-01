class ConnectFour
  BOARD_WIDTH = 7
  BOARD_HEIGHT = 6

  attr_reader :board, :player

  def initialize
    @board = Array.new(BOARD_HEIGHT) { Array.new(BOARD_WIDTH) { ' ' } }
    @player = 1
  end

  def play
    print_welcome
    loop do
      apply_move(get_input)
      print_state
      break if winner?

      self.player = player == 1 ? 2 : 1
    end
    print_conclusion
  end

  private

  attr_writer :board, :player

  def print_welcome
  end

  def apply_move(column)
  end

  def get_input
  end

  def print_state
  end

  def winner?
  end

  def print_conclusion
  end
end
