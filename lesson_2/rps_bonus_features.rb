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

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer Won.")
  else
    prompt("It's a tie.")
  end
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

choice = ""

loop do # Match Loop
  player_score = 0
  computer_score = 0
  round = 1

  loop do # Round Loop
    Kernel.puts("------------Round #{round}-------------")
    loop do # Player Choice
      prompt("Choose one: #{VALID_CHOICES.join(', ')}.")
      choice = Kernel.gets().chomp().downcase()

      if VALID_CHOICES.include?(choice)
        break
      elsif ABB_VALID_CHOICES.include?(choice)
        choice = expand_selection(choice)
        break
      elsif choice == 's'
        prompt("Please enter 'sc' for scissors or 'sp' for spock.")
      else
        prompt("That's not a valid choice.")
      end
    end

    computer_choice = VALID_CHOICES.sample

    Kernel.puts("You chose: #{choice}; Computer chose: #{computer_choice}.")
    display_results(choice, computer_choice)

    # score + round update
    if win?(choice, computer_choice)
      player_score += 1
    elsif choice != computer_choice
      computer_score += 1
    end

    round += 1
    Kernel.puts("You -- #{player_score}, Computer -- #{computer_score}")

    # check if winner exists
    if player_score == 3
      prompt("You've won the match!")
      break
    elsif computer_score == 3
      prompt("Computer has won match!")
      break
    end
  end
  prompt("Another Match? (Y/N)")
  again = Kernel.gets().chomp().downcase()

  break unless again.start_with?("y")
end

prompt("See you next time!")
