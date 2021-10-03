=begin
About: his is my attempt at solving the tictactoe game by myself.

Improvements:
I think the code could be cleaned up a lot. 
There's a lot of repetition happening,
and there's gotta be better ways to solve this.

Algorithm:
1. Display empty board
2. Ask user for choice
3. display new board
4. check for winner / tie
5. Ask computer for choice
6. Display new board
7. Check for winner /tie
8. Go back to 2
9. Play again? Yes: go back to 1
10. Goodbye

Notes
- If board != int -> "invalid choice"
- if row1.all?("X") -> user winner
- if row1.all?("O") -> computer winner
- if row1[0], row2[1], row[2].all("X")
- check for winner (input x, user)
- check for winner (input o, computer)
- input (1-9)
- X winner possibilities:
  - Horizontal wins:
    - rows[0][0], rows[0][1], rows[0][2] == X
    - rows[1][0], rows[1][1], rows[1][2] == X
    - rows[2][0], rows[2][1], rows[2][2] == X
  - Diagonal Wins:
    - rows[0][0], rows[1][1], rows[2][2] == X
    - rows[0][2], rows[1][1], rows[2][0] == x
  - Vertical Wins:
    - rows[0][0], rows[1][0], rows[2][0] == x
    - rows[0][1], rows[1][1], rows[2][1] == x
    - rows[0][2], rows[1][2], rows[2][2] == x

=end


def display_board(rows)
  puts ""
  puts "     |     |"
  puts "  #{rows[0][0]}  |  #{rows[0][1]}  |  #{rows[0][2]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{rows[1][0]}  |  #{rows[1][1]}  |  #{rows[1][2]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{rows[2][0]}  |  #{rows[2][1]}  |  #{rows[2][2]}"
  puts "     |     |"
  puts ""
end

def valid_choice?(rows, choice)
  if (1..3).include?(choice) and 
     rows[0][choice-1].to_s.to_i == rows[0][choice-1]
    return true
  elsif (4..6).include?(choice) and
        rows[1][choice-4].to_s.to_i == rows[1][choice-4]
    return true
  elsif (7..9).include?(choice) and
        rows[2][choice-7].to_s.to_i == rows[2][choice-7]
    return true
  else
    return false
  end 
end

def mark_board(choice, rows, player)
  if choice <= 3 
    rows[0][choice - 1] = player
  elsif choice <= 6
    rows[1][choice - 4] = player
  elsif choice <= 9 
    rows[2][choice - 7] = player
  else
    puts "invalid choice. try again"
  end
  display_board(rows)
end  

def computer_choice(rows)
  choice = 0
  loop do
    choice = rand(1..9)
  break if valid_choice?(rows, choice)
  end
  choice
end

def horizontal_winner?(player, rows)
  if rows[0].all?(player) ||
    rows[1].all?(player) ||
    rows[2].all?(player)
  then
    true
  else
    false
  end
end

def vertical_winner?(player, rows)

  # collecting vertical data 
  grid = []
  row_counter = 0
  column_counter = 0
  3.times do 
    row_counter = 0
    columns = []
    3.times do 
      columns << rows[row_counter][column_counter]
      row_counter += 1
    end
    grid << columns
    column_counter += 1
  end
  
  # checking if winner exists
  if grid[0].all?(player) ||
     grid[1].all?(player) ||
     grid[2].all?(player)
  then true
  else false
  end

end

def diagonal_winner?(player, rows)
  diagonals1 = []
  diagonals1 << rows[0][0]
  diagonals1 << rows[1][1]
  diagonals1 << rows[2][2]

  diagonals2 = []
  diagonals2 << rows[0][2]
  diagonals2 << rows[1][1]
  diagonals2 << rows[2][0]
  if diagonals1.all?(player) ||
     diagonals2.all?(player) 
  then true
  else false
  end
end


def winner?(player, rows)
  if horizontal_winner?(player, rows) ||
     vertical_winner?(player, rows) ||
     diagonal_winner?(player, rows)
  then 
    puts "#{player} wins!"
    return true
  else false
  end
end

def tie?(rows)
  board_state = []
  rows.each do |array|
    array.each do |item|
      board_state << (item.to_s.to_i == item)
    end
  end
  if board_state.all?(false)
    puts "It's a tie!"
    return true
  else
    return false
  end
end

def end_round?(user, computer, rows)
  if winner?(user, rows) || winner?(computer, rows)
    return true
  elsif tie?(rows)
    return true
  else
    return false
  end
end


user = "X"
computer = "O"

loop do

  row1 = [1, 2, 3]
  row2 = [4, 5, 6]
  row3 = [7, 8, 9]
  rows = [row1, row2, row3]

  display_board(rows)

  loop do # main loop
    puts "Please choose an available section (1-9)"
    choice = gets.chomp.to_i

    if valid_choice?(rows, choice)
      mark_board(choice, rows, user) 
    else
      puts "Sorry that choice is invalid, please try again."
    end

    break if end_round?(user, computer, rows)

    mark_board(computer_choice(rows), rows, computer)

    break if end_round?(user, computer, rows)

  end
  puts "Play again? Y or N"
  play_again = gets.chomp.upcase

  break if play_again.start_with?("N")

end
puts "Goodbye!"

# row1 = ["O", "X", 3]
# row2 = ["X", 5, "O"]
# row3 = ["X", "X", "O"]
# rows = [row1, row2, row3]

# p end_round?(user,computer,rows)
