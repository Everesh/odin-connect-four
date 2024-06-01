class ConnectFour
  BOARD_WIDTH = 7
  BOARD_HEIGHT = 6
  PLAYER_ONE = 'X'.freeze
  PLAYER_TWO = 'O'.freeze

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
    puts ' .--.                               .-.   .---.               '
    puts ": .--'                             .' `.  : .--'              "
    puts ": :    .--. ,-.,-.,-.,-. .--.  .--.`. .'  : `;.--. .-..-..--. "
    puts ": :__ ' .; :: ,. :: ,. :' '_.''  ..': :   : :' .; :: :; :: ..'"
    puts "`.__.'`.__.':_;:_;:_;:_;`.__.'`.__.':_;   :_;`.__.'`.__.':_;  "
    puts
  end

  def apply_move(column)
    depth = BOARD_HEIGHT - 1
    depth -= 1 until board[depth][column] == ' '
    board[depth][column] = player == 1 ? PLAYER_ONE : PLAYER_TWO
  end

  def get_input
    puts "Player#{player}, give me a number 1 - #{BOARD_WIDTH}:"
    begin
      input = gets.chr.to_i
      raise StandardError if input > BOARD_WIDTH || input < 1
    rescue StandardError
      puts '### Invalid input, try again!'
      retry
    end
    input - 1
  end

  def print_state
    line = '+'
    board[0].length.times { line.concat('---+') }
    puts line
    board.each.with_index do |_row, index|
      print '|'
      board[index].each { |item| print " #{item} |" }
      puts
      puts line
    end
  end

  def winner?
  end

  def print_conclusion
    puts '  .__.'
    puts ' (|  |)'
    puts '  (  )'
    puts "  _)(_  Player#{player} WON!"
  end
end
