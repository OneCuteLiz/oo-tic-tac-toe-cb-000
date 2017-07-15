class TicTacToe

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Bottom row
    [0,3,6], # Left column
    [1,4,7], # Center column
    [2,5,8], # Right column
    [0,4,8], # First diagonal
    [2,4,6]  # Last diagonal
    ]

  def initialize (board = nil)
    @board = board || Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    @index = user_input.to_i - 1
  end

  def move(index, token = "X")
    @board[index] = token
  end

  def position_taken?(index)

    #if position is free return false. Else, true.
      !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    position_taken?(index) == false && index.between?(0, 8)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    newinput = input_to_index(input)

    if valid_move?(newinput)
      move(newinput, current_player)
      puts display_board

    else
      turn
    end

  end

  def current_player

    if turn_count.even?
      "X"
    else
      "O"
    end
  end



  def turn_count
    counter = 0

    @board.each do |position|

      if position == nil || position == " " || position == ""
      else
        counter += 1
      end
    end
    return counter
  end



  def x_won?
    @who_won = "X"
    WIN_COMBINATIONS.detect do |combo_array|
        combo_array.all? do |combo_index|
          position_taken?(combo_index) == true && @board[combo_index] == "X"
        end
      end
  end

  def o_won?
    @who_won = "O"
    WIN_COMBINATIONS.detect do |combo_array|
        combo_array.all? do |combo_index|
          position_taken?(combo_index) == true && @board[combo_index] == "O"
        end
      end
  end


  def won?
    if x_won? != nil
      puts "Congratulations X!"
      x_won?
    elsif o_won? != nil
      puts "Congratulations O!"
      o_won?
    else
      @who_won = nil
      false
    end
  end

  def full?
  #return true if every board element is filled

    WIN_COMBINATIONS.all? do |combo_array|
      combo_array.all? do |combo_index|
        position_taken?(combo_index)
      end
    end
  end

  def draw?

    if won? != false
      return false
    else
      puts "Cat's Game!"
      full?
    end
  end

  def over?

    if won? != false || draw? == true || full? == true
      true
    else
      false
    end
  end

  def winner
    won?
    @who_won
  end

  def play
    return if over?
    turn
    play
  end

end
