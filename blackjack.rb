# first implementation, need to refactor

require 'pry'

# build the deck

single_deck = [{ card: 'Ace', suit: :spades, value:  11 },
               { card: '2', suit: :spades, value: 2 },
               { card: '3', suit: :spades, value: 3 },
               { card: '4', suit: :spades, value: 4 },
               { card: '5', suit: :spades, value: 5 },
               { card: '6', suit: :spades, value: 6 },
               { card: '7', suit: :spades, value: 7 },
               { card: '8', suit: :spades, value: 8 },
               { card: '9', suit: :spades, value: 9 },
               { card: '10', suit: :spades, value: 10 },
               { card: 'Jack', suit: :spades, value: 10 },
               { card: 'Queen', suit: :spades, value: 10 },
               { card: 'King', suit: :spades, value: 10 },
               { card: 'Ace', suit: :hearts, value: 11 },
               { card: '2', suit: :hearts, value: 2 },
               { card: '3', suit: :hearts, value: 3 },
               { card: '4', suit: :hearts, value: 4 },
               { card: '5', suit: :hearts, value: 5 },
               { card: '6', suit: :hearts, value: 6 },
               { card: '7', suit: :hearts, value: 7 },
               { card: '8', suit: :hearts, value: 8 },
               { card: '9', suit: :hearts, value: 9 },
               { card: '10', suit: :hearts, value: 10 },
               { card: 'Jack', suit: :hearts, value: 10 },
               { card: 'Queen', suit: :hearts, value: 10 },
               { card: 'King', suit: :hearts, value: 10 },
               { card: 'Ace', suit: :diamonds, value: 11 },
               { card: '2', suit: :diamonds, value: 2 },
               { card: '3', suit: :diamonds, value: 3 },
               { card: '4', suit: :diamonds, value: 4 },
               { card: '5', suit: :diamonds, value: 5 },
               { card: '6', suit: :diamonds, value: 6 },
               { card: '7', suit: :diamonds, value: 7 },
               { card: '8', suit: :diamonds, value: 8 },
               { card: '9', suit: :diamonds, value: 9 },
               { card: '10', suit: :diamonds, value: 10 },
               { card: 'Jack', suit: :diamonds, value: 10 },
               { card: 'Queen', suit: :diamonds, value: 10 },
               { card: 'King', suit: :diamonds, value: 10 },
               { card: 'Ace', suit: :clubs, value: 11 },
               { card: '2', suit: :clubs, value: 2 },
               { card: '3', suit: :clubs, value: 3 },
               { card: '4', suit: :clubs, value: 4 },
               { card: '5', suit: :clubs, value: 5 },
               { card: '6', suit: :clubs, value: 6 },
               { card: '7', suit: :clubs, value: 7 },
               { card: '8', suit: :clubs, value: 8 },
               { card: '9', suit: :clubs, value: 9 },
               { card: '10', suit: :clubs, value: 10 },
               { card: 'Jack', suit: :clubs, value: 10 },
               { card: 'Queen', suit: :clubs, value: 10 },
               { card: 'King', suit: :clubs, value: 10 }
             ]

# check is there is an "Ace"

def check_a?(hand)
  hand.any? { |card| card[:card] == 'Ace' }
end

# check if is blackjack

def check_blackjack?(value)
  return true if value == 21
end

# calculate the value of the hand

def calculate(hand)
  hand_value = hand.map { |s| s[:value] }.reduce(0, :+)
end

# turn a card with animation and print output

def turn_card(player, card_deck)
  card = card_deck.shift
  puts "The card is a #{card[:card]} of #{card[:suit]}"
  player << card
  puts "Now you have:"
  puts
  print_card player
  puts
end

# shuffle the card deck

def shuffle(card_deck)
  card_deck.shuffle!
  (1..10).each do |pause|
    sleep 0.1
    print '*' 
  end
end

# print the card of a deck

def print_card(deck)
   deck.each{ |card| puts "#{card[:card]} of #{card[:suit]}" } 
end

# print the card of the dealer in the first hand (one card is covered)

def print_dealer_firsthand(deck)
   puts "#{deck[0][:card]} of #{deck[0][:suit]}" 
end

# Count the number aces in a hand
def count_aces(card_deck)
  count = 0
  card_deck.each do |card|
    count = count + 1 if card[:card] == "Ace"
  end
  return count
end

# compensate value with aces

def compensate(player, value)
  (1..count_aces(player)).each do |dec|
  value = value - 10 if value > 21
  end   
end

# PROGRAM START

puts 'Welcome to BlackJack. To play I need to know your name'
sleep 1
puts "What's your name? Type it"
player_name = gets.chomp
puts

puts "Hello #{player_name}.  Do you want to play with single deck or with a shoe (4 decks)?"
puts
puts '1) Single deck game'
puts '2) 4 decks of cards'
game_type = gets.chomp

# build the match deck : you can choose beetween single deck and 4 deck game

if game_type == "1"
  card_deck = single_deck
else
  card_deck = single_deck * 4
end

# shuffle the card

puts "Good, I'm shuffling the cards"

shuffle(card_deck)

puts "Card shuffled, here are your cards..."
puts

# give the cards

player_hand = card_deck.shift(2)
dealer_hand = card_deck.shift(2)

dealer_hand_value = calculate(dealer_hand)
player_hand_value = calculate(player_hand)

puts
puts "You have these cards: "
puts
print_card(player_hand)
puts

puts "Dealer has these card:"
puts
puts "The dealer show this card for a value of #{dealer_hand[0][:value]}"
print_dealer_firsthand(dealer_hand)

# check if player has blackjack before playing

if check_blackjack?(player_hand_value)
  puts 'Wow, you have BlackJack, you win'
  exit
end

# check if dealer has blackjack before playing

if check_blackjack?(dealer_hand_value)
  puts "I'm sorry, dealer has BlackJack. He win"
  exit
end

while player_hand_value < 22

  puts
  puts 'What do you want do do?'
  puts '1) Hit'
  puts '2) Stay'

  choice = gets.chomp

  if choice == '1'
    puts 'You choose to turn card'
    turn_card(player_hand, card_deck)
    sleep 1
    player_hand_value = calculate(player_hand)

    if player_hand_value > 21 && check_a?(player_hand)
       player_hand_value = compensate(player_hand, player_hand_value)
    end
    
    if player_hand_value > 21
      puts "You busted with #{player_hand_value}, I'm sorry. Dealer win"
      exit
    else
      puts "You have #{player_hand_value}. What do you want to do?"
    end
  elsif choice == '2'
    break
  else
    if !['1', '2'].include?(choice)
    puts 'Error: you must enter 1 or 2'
    end
  end
end

while dealer_hand_value < 17
  puts "The dealer has #{dealer_hand_value} and must turn another card"
  turn_card(dealer_hand, card_deck)
  dealer_hand_value = calculate(dealer_hand)
  sleep 1
    
  if dealer_hand_value.between?(17, 21)
    puts "Dealer has #{dealer_hand_value} and must stay"
    break
  elsif dealer_hand_value > 21 && check_a?(dealer_hand)
    dealer_hand_value = compensate(dealer_hand, dealer_hand_value)
  elsif dealer_hand_value > 21
    puts 'Dealer bust, you win'
    break
  end
end

if dealer_hand_value > player_hand_value
  puts "Sorry, dealer wins with #{dealer_hand_value} agaist #{player_hand_value}"
elsif dealer_hand_value < player_hand_value
  puts "Wow, you win with #{player_hand_value} agaist #{dealer_hand_value}"
else
  puts 'Tie match. Play again'
end

exit