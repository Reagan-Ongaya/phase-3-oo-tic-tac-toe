require "pry"
class TicTacToe
    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

    end


  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]
    def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(board_index, token="X")
    @board[board_index] = token
  end

  def position_taken?(prospective_index)
    @board[prospective_index] != " "
  end

  def valid_move?(index_position)
    !position_taken?(index_position) && (0..8).include?(index_position)
  end

  def turn_count
    
    @board.count {|move| move != " "}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    puts "Enter your move. Should be within range (1-9):"
    user_input = gets.chomp()
    index = input_to_index(user_input)
    if valid_move?(index)
      player_token = current_player
      move(index, player_token)
      display_board
    else
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.any? do |combination|
      if position_taken?(combination[0]) 
        if @board[combination[0]] == @board[combination[1]] && @board[combination[1]] == @board[combination[2]]
          return combination
        end
      end

    end

  end

  def full?
    !@board.include? " "
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || full?
  end

  def winner
    if won?
      winning_combinations = won?
      @board[winning_combinations[0]]
    end
  end

  def play
    until over? do
      turn
      if draw?
        return
      end
    end
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
  end

end