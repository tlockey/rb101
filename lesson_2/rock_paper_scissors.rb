VALID_CHOICES = %w(rock paper scissors)

def display_results(player, computer)
  if (player == 'rock' && computer == 'scissors') ||
     (player == 'paper' && computer == 'rock') ||
     (player == 'scissors' && computer == 'paper')
    prompt("You won!")
  elsif (player == 'rock' && computer == 'paper') ||
        (player == 'paper' && computer == 'scissors') ||
        (player == 'scissors' && computer == 'rock')
    prompt("Computer Won.")
  else
    prompt("It's a tie.")
  end
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

choice = ""

loop do
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}.")
    choice = Kernel.gets().chomp()

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  Kernel.puts("You chose: #{choice}; Computer chose: #{computer_choice}.")

  display_results(choice, computer_choice)

  prompt("Another Game? (Y/N)")
  again = Kernel.gets().chomp().downcase()

  break unless again.start_with?("y")
end

prompt("See you next time!")
