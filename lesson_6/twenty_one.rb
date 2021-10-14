=begin
21 game

Personal notes:
  data structures:
  array? hash?
  if array, i have to figure out how to deal with jack queen king and ace values
  if hash, i can just assign values to the key,
    can i have a value of the hash where it's in the hand vs not?
  {2: {value: 2, position: in_deck}, 3:{value:3, position: on_hand}}
  [2,3,4,5,6,7,8,9,10,]
  [[2,2,0],]
  array for in hand
  hash for deck

Steps:
1. initialize deck
  - deck has 52-cards
  - 2, 3 4, 5, 6, 7, 8, 9, 10, jack, queen, king, ace
  - jack, queen, king are worth 10 each
  - ace can be worth 11 or 1

2. Deal Cards to player and Dealer (2 cards)
  - sample from deck, position: in_deck
  - must
3. Player Turn: hit or stay
4. If player bust, dealer wins
5. Dealer turn: hit or stay
- repeat until total >= 17
6. If dealer bust, player wins
7. Compare cards and declare winner

Improvements: (/. means done)
/. Show total on each round
/. Take joinor function from tictactoe + implement here
/. enable shortcuts for hit + stay
/. Show what dealer does (leave a dealer trail of action)
/. Add prompt method
/. store result of calculate value in a local variable
/. keep track of rounds/points
/. use constants for upper limit number
/. extract detect results and display results into methods

=end

require 'pry'
SUITS = %w(Hearts Diamonds Clubs Spades)
CARDS = %w(1 2 3 4 5 6 7 8 9 Jack Queen King Ace)

GAME_TITLE = "Twenty-One"
TO_WIN = 21
TO_STAY = 17

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  deck = []
  SUITS.each do |suit|
    CARDS.each do |card|
      deck << [suit, card]
    end
  end
  deck
end

def deal_card(hand, deck, number = 1)
  number.times do
    hand << deck.sample
    hand.each do |dcard|
      deck.reject! { |card| card == dcard }
    end
  end
end

def calculate_value(hand)
  values = hand.map { |card| card[1] }
  total_value = 0
  values.each do |card|
    case card
    when 'Jack', 'Queen', 'King'
      total_value += 10
    when 'Ace'
      total_value += 11
    else
      total_value += card.to_i
    end
  end
  values.select { |value| value == 'Ace' }.count.times do
    total_value -= 10 if total_value > TO_WIN
  end
  total_value
end

def busted?(total)
  total > TO_WIN
end

# :player_busted, :dealer_busted, :player, :dealer, :tie
def detect_result(player_total, dealer_total)
  if player_total > TO_WIN
    :player_busted
  elsif dealer_total > TO_WIN
    :dealer_busted
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_result(player_total, dealer_total)
  result = detect_result(player_total, dealer_total)

  case result
  when :player_busted
    prompt "You busted! Dealer wins!"
  when :dealer_busted
    prompt "Dealer busted! You win!"
  when :player
    prompt "You win!"
  when :dealer
    prompt "Dealer wins!"
  when :tie
    prompt "It's a tie!"
  end
end

def display_end_round(player_total, dealer_total)
  puts "======================="
  prompt("Dealer total is #{dealer_total}; Player total is" \
        " #{player_total}")

  puts "======================="
  display_result(player_total, dealer_total)
end

def joinand(hand, joiner = ', ', last_joiner = 'and')
  # hand = [["Clubs", "4"], ["Hearts", "4"]...]
  final_string = ''
  hand.each_with_index do |card, idx|
    if hand.size == 1
      return final_string << "#{card[1]} of #{card[0]}"
    elsif idx == hand.size - 1
      final_string << "#{last_joiner} #{card[1]} of #{card[0]}"
    else
      final_string << "#{card[1]} of #{card[0]}#{joiner}"
    end
  end
  final_string
end

def continue_pause
  prompt "Press any key to continue."
  gets.chomp
end

def play_again?
  prompt("Would you like to play again? (Y/N)")
  answer = gets.chomp.downcase
  answer.start_with?('y')
end

loop do # starting game
  system 'clear'

  # initializing player points
  player_points = 0
  dealer_points = 0

  # welcome screen
  prompt("Welcome to #{GAME_TITLE}!")
  prompt "First player to 5 points wins."
  continue_pause

  round_counter = 1
  loop do # starting round
    system 'clear'
    prompt "ROUND #{round_counter}"
    prompt "POINTS: Dealer: #{dealer_points}; Player: #{player_points}"
    puts "=================================================="
    break if player_points == 5 || dealer_points == 5

    # initializing variables
    player_cards = []
    dealer_cards = []

    deck = initialize_deck

    # dealing initial hand
    deal_card(player_cards, deck, 2)
    deal_card(dealer_cards, deck, 2)

    # calculating total
    dealer_total = calculate_value(dealer_cards)
    player_total = calculate_value(player_cards)

    # displaying hand
    prompt("Dealer has: #{joinand([] << dealer_cards.first)} " \
          "and an unknown card.")
    prompt("You have: #{joinand(player_cards)}")
    prompt("Your total is now: #{player_total}")

    # player turn
    loop do
      answer = nil
      loop do
        prompt("Would you like to (H)it or (S)tay?")
        answer = gets.chomp.downcase.chr
        break if ['h', 's'].include?(answer)
        prompt("Sorry, must enter 'H' for 'Hit or 'S' for 'Stay'.")
      end

      # if player hits
      if answer == 'h'
        deal_card(player_cards, deck) if answer == 'h'
        prompt("You chose to hit!")
        prompt("You now have: #{joinand(player_cards)}")
        player_total = calculate_value(player_cards)
        prompt("Your total is now #{player_total}")
      end

      break if answer == 's' || busted?(player_total)
    end

    # if player busted or stayed
    if busted?(player_total)
      display_end_round(player_total, dealer_total)
      continue_pause
      dealer_points += 1
      round_counter += 1
      next
    else
      prompt("You chose to stay at #{player_total}")
      puts "======================="
      prompt("Dealer's Turn...")
    end

    # dealer's turn
    loop do
      if dealer_total >= TO_STAY
        prompt("Dealer Stays at #{dealer_total}!")
        break
      end

      # dealer hits
      prompt("Dealer hits!")
      deal_card(dealer_cards, deck)
      prompt("Dealer now has: #{joinand(dealer_cards)}")
      dealer_total = calculate_value(dealer_cards)
      prompt("Dealer's total is now #{dealer_total}")
    end

    # if dealer busted or stayed / end of round
    display_end_round(player_total, dealer_total)
    if busted?(dealer_total)
      player_points += 1
    else
      result = detect_result(player_total, dealer_total)
      if result == :dealer
        dealer_points += 1
      elsif result == :player
        player_points += 1
      end
    end
    # pause before clear screen + increment round
    continue_pause
    round_counter += 1
  end

  prompt "GAME OVER"
  player_points == 5 ? prompt("You win!") : prompt("Dealer wins!")
  break unless play_again?
end
prompt("Thank you for playing #{GAME_TITLE}! Good bye!")
