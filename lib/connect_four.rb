class ConnectFour
  BOARD_WIDTH = 7
  BOARD_HEIGHT = 6

  attr_reader :board

  def initialize
    @board = Array.new(BOARD_HEIGHT) { Array.new(BOARD_WIDTH) { ' ' } }
  end

  private

  attr_writer :board
end
