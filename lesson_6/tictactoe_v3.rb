=begin
This program is an improvement over v2, based on Launch School's Bonus
Features Lesson. It's my attempt at adding some of the features they 
suggested. 

1. Improved 'Join'. Inputs: Array, joiner, last joiner(default = 'or')
  - iterate over array
  - add each item to empty string + joiner unless it's the last item
  - if it's the last item, add the last joiner before it. 
2. Keep Score: first player to reach 5 wins the game
  - added 'press enter to continue, in order to pause screen'
3. Computer AI: Defense
  - immediate threat: "2 squares in a row from opponent"
  - if immediate threat: defend 3rd square
  - if no immediate threat, pick at random
4. Computer AI: Offense 
5. Computer Picks 5 if available
6. Change who goes first by user input or random

=end
require 'pry'

INITIAL_MARKER = ' '
USER = 'X'
COMPUTER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # horizontal
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # vertical
                [[1, 5, 9], [3, 5, 7]] # diagonal
PLAYERS = ['me', 'computer']

def joinor(array, joiner = ', ', last_joiner = 'or')
  final_string = ''
  array.each_with_index do |item, idx|
    if array.size == 1
      return final_string << "#{item}"
    elsif idx == array.size - 1
      final_string << "#{last_joiner} #{item}"
    else
      final_string << "#{item}#{joiner}"
    end
  end
    final_string
end

def initialize_board
  { 1 => INITIAL_MARKER, 2 => INITIAL_MARKER, 3 => INITIAL_MARKER,
    4 => INITIAL_MARKER, 5 => INITIAL_MARKER, 6 => INITIAL_MARKER,
    7 => INITIAL_MARKER, 8 => INITIAL_MARKER, 9 => INITIAL_MARKER }
end

def display_board(rows, player_points, computer_points)
  system 'clear'
  puts "You're an #{USER}. Computer is #{COMPUTER}."
  puts "Current Score: You: #{player_points}; Computer: #{computer_points}"
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
end

def turn(rows,current_player)
  if current_player == 'me'
    player_turn(rows)
  elsif current_player == 'computer'
    mark_board!(computer_choice(rows), rows, COMPUTER)
  end
end

def alternate_player(current_player)
  PLAYERS.select{|x| x != current_player}.first
end

def player_turn(rows)
  choice = ''
  loop do
    puts "Please choose an available section: #{joinor(empty_squares(rows))}"
    choice = gets.chomp.to_i

    break if valid_choice?(rows, choice)
    puts "Sorry that choice is invalid, please try again."
  end
  mark_board!(choice, rows, USER)
end

def computer_choice(rows)
  choice = nil
  WINNING_LINES.each do |line|
    if rows.values_at(*line).count(COMPUTER) == 2
      line.each do |key|
        choice = key if rows[key] == " "
      end
    end
  end

  if !choice
    WINNING_LINES.each do |line|
      if rows.values_at(*line).count(USER) == 2
        line.each do |key|
          choice = key if rows[key] == " "
        end
      end
    end
  end

  if !choice && empty_squares(rows).include?(5)
    choice = 5
  end

  if !choice
    choice = empty_squares(rows).sample
  end
  choice
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
  player_points = 0
  computer_points = 0
  current_player = nil
  loop do
    puts "Who goes first? (Me, Computer, Random)"
    current_player = gets.chomp.downcase
    current_player = PLAYERS.sample if current_player == 'random'
    break if  PLAYERS.include?(current_player)
    puts "Sorry, choice is invalid. Try Again"
  end #loop
  
  loop do # round begins
    rows = initialize_board
    display_board(rows, player_points, computer_points)
    
    loop do
      turn(rows,current_player)
      current_player = alternate_player(current_player)
      display_board(rows, player_points, computer_points)
      break if winner?(rows) || tie?(rows)
    end

    if winner?(rows)
      if detect_winner(rows) == 'Player'
        player_points += 1
      else
        computer_points += 1
      end
      display_board(rows, player_points, computer_points)
      puts "#{detect_winner(rows)} won!"
    else
      puts "It was a tie!"
    end
    
    if player_points == 5 || computer_points == 5
      puts "#{detect_winner(rows)} won the game!"
      break
    end

    puts "Hit enter to go to next round."
    enter = gets.chomp

  end
  puts "Play again? Y or N"
  play_again = gets.chomp.upcase

  break if play_again.start_with?("N")
end

puts "Thanks for playing Tic Tac Toe. Goodbye!"
