=begin
This program improves upon my first attempt after watching
the walk through videos on launch school.

1. Change data structure from array to hash for easier access
2. Initialize board as empty space to reduce clutter (hard to see which
spots are still available)
3. create empty squares method in order to have a list of valid choices
4. extract values to constants
5. add system 'clear' to display board method
6. extracted player turn to its own method
7. refactored winner selection process (from 4 methods into 1)
8. extracted new board into initialize board method
9. Added legend on top (user is x, computer is O)
=end

INITIAL_MARKER = ' '
USER = 'X'
COMPUTER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # horizontal
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # vertical
                [[1, 5, 9], [3, 5, 7]] # diagonal

def initialize_board
  { 1 => INITIAL_MARKER, 2 => INITIAL_MARKER, 3 => INITIAL_MARKER,
    4 => INITIAL_MARKER, 5 => INITIAL_MARKER, 6 => INITIAL_MARKER,
    7 => INITIAL_MARKER, 8 => INITIAL_MARKER, 9 => INITIAL_MARKER }
end

def display_board(rows)
  system 'clear'
  puts "You're an #{USER}. Computer is #{COMPUTER}."
  puts ""
  puts "     |     |"
  puts "  #{rows[1]}  |  #{rows[2]}  |  #{rows[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{rows[4]}  |  #{rows[5]}  |  #{rows[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{rows[7]}  |  #{rows[8]}  |  #{rows[9]}"
  puts "     |     |"
  puts ""
end

def empty_squares(rows)
  rows.keys.select { |num| rows[num] == INITIAL_MARKER }
end

def valid_choice?(rows, choice)
  return true if empty_squares(rows).include?(choice)
  false
end

def mark_board!(choice, rows, player)
  rows[choice] = player
  display_board(rows)
end

def player_turn(rows)
  choice = ''
  loop do
    puts "Please choose an available section #{empty_squares(rows)}"
    choice = gets.chomp.to_i

    break if valid_choice?(rows, choice)
    puts "Sorry that choice is invalid, please try again."
  end
  mark_board!(choice, rows, USER)
end

def computer_choice(rows)
  empty_squares(rows).sample
end

def winner?(rows)
  !!detect_winner(rows)
end

def detect_winner(rows)
  WINNING_LINES.each do |line|
    if rows.values_at(*line).count(USER) == 3
      return 'Player'
    elsif rows.values_at(*line).count(COMPUTER) == 3
      return 'Computer'
    end
  end
  nil
end

def tie?(rows)
  return true if empty_squares(rows) == []
  false
end

loop do
  rows = initialize_board
  display_board(rows)

  loop do # main loop
    player_turn(rows)
    break if winner?(rows) || tie?(rows)

    mark_board!(computer_choice(rows), rows, COMPUTER)
    break if winner?(rows) || tie?(rows)
  end

  if winner?(rows)
    puts "#{detect_winner(rows)} won!"
  else
    puts "It was a tie!"
  end

  puts "Play again? Y or N"
  play_again = gets.chomp.upcase

  break if play_again.start_with?("N")
end

puts "Thanks for playing Tic Tac Toe. Goodbye!"
