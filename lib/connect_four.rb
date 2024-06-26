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
      break if winner? || board[0].all? { |position| position != ' ' }

      self.player = player == 1 ? 2 : 1
    end
    board[0].all? { |position| position != ' ' } ? print_draw : print_conclusion
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
      raise ArgumentError if board[0][input - 1] != ' '
    rescue ArgumentError
      puts '### Column is full, try again!'
      retry
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
    sequences = board + board.transpose + diagonals
    sequences.any? { |sequence| sequence.join.match?(/#{PLAYER_ONE}{4}|#{PLAYER_TWO}{4}/) }
  end

  def diagonals
    diagonals = []
    rows = board.size
    cols = board[0].size

    (0...rows).each do |i|
      (0...cols).each do |j|
        diagonals << (0..3).map { |k| board[i + k][j + k] } if i + 3 < rows && j + 3 < cols
        diagonals << (0..3).map { |k| board[i + k][j - k] } if i + 3 < rows && j - 3 >= 0
      end
    end

    diagonals
  end

  def print_conclusion
    puts '  .__.'
    puts ' (|  |)'
    puts '  (  )'
    puts "  _)(_  Player#{player} WON!"
  end

  def print_draw
    puts 'Its a DRAW!'
  end
end
