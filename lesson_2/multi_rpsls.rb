VALID_CHOICES = %w(rock paper scissors lizard spock)
ABB_VALID_CHOICES = %w(r p sc l sp)

CHOICE_DEFEATS = { 'rock': ['scissors', 'lizard'],
                   'paper': ['rock', 'spock'],
                   'scissors': ['paper', 'lizard'],
                   'lizard': ['spock', 'paper'],
                   'spock': ['scissors', 'rock'] }

def win?(first, second)
  CHOICE_DEFEATS[first.to_sym].include?(second)
end

def expand_selection(abbreviation)
  case abbreviation
  when 'r' then 'rock'
  when 'p' then 'paper'
  when 'sc' then 'scissors'
  when 'l' then 'lizard'
  when 'sp' then 'spock'
  end
end

def display_results(p1, p2, p1_name, p2_name)
  if win?(p1, p2)
    prompt("#{p1_name} won!")
  elsif win?(p2, p1)
    prompt("#{p2_name} Won.")
  else
    prompt("It's a tie.")
  end
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

p1_choice = ""
p2_choice = ""

print "Enter Player 1's Name --> "
p1_name = gets.chomp

print "Enter Player 2's Name --> "
p2_name = gets.chomp

loop do # Match Loop
  p1_score = 0
  p2_score = 0
  round = 1

  loop do # Round Loop
    Kernel.puts("------------Round #{round}-------------")
    loop do # Player Choice
      prompt("#{p1_name} Choose one: #{VALID_CHOICES.join(', ')}.")
      p1_choice = Kernel.gets().chomp().downcase()

      if VALID_CHOICES.include?(p1_choice)
        break
      elsif ABB_VALID_CHOICES.include?(p1_choice)
        p1_choice = expand_selection(p1_choice)
        break
      elsif p1_choice == 's'
        prompt("Please enter 'sc' for scissors or 'sp' for spock.")
      else
        prompt("That's not a valid choice.")
      end
    end

    loop do # Player Choice
      prompt("#{p2_name} Choose one: #{VALID_CHOICES.join(', ')}.")
      p2_choice = Kernel.gets().chomp().downcase()

      if VALID_CHOICES.include?(p2_choice)
        break
      elsif ABB_VALID_CHOICES.include?(p2_choice)
        p2_choice = expand_selection(p2_choice)
        break
      elsif choice == 's'
        prompt("Please enter 'sc' for scissors or 'sp' for spock.")
      else
        prompt("That's not a valid choice.")
      end
    end
    # computer_choice = VALID_CHOICES.sample

    Kernel.puts("#{p1_name} chose: #{p1_choice}; #{p2_name} chose: #{p2_choice}.")
    display_results(p1_choice, p2_choice, p1_name, p2_name)

    # score + round update
    if win?(p1_choice, p2_choice)
      p1_score += 1
    elsif p1_choice != p2_choice
      p2_score += 1
    end

    round += 1
    Kernel.puts("#{p1_name} -- #{p1_score}, #{p2_name}-- #{p2_score}")

    # check if winner exists
    if p1_score == 3
      prompt("#{p1_name} won the match!")
      break
    elsif p2_score == 3
      prompt("#{p2_name} has won match!")
      break
    end
  end
  prompt("Another Match? (Y/N)")
  again = Kernel.gets().chomp().downcase()

  break unless again.start_with?("y")
end

prompt("See you next time!")
