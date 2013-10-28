#first implementation without handling multiple ace value

require 'pry'

player_hand = []
dealer_hand = []

#build the deck

single_deck =[ {card:"A", suit: :spades, value:11},
               {card:"2", suit: :spades, value:2},
               {card:"3", suit: :spades, value:3},
               {card:"4", suit: :spades, value:4},
               {card:"5", suit: :spades, value:5},
               {card:"6", suit: :spades, value:6},
               {card:"7", suit: :spades, value:7},
               {card:"8", suit: :spades, value:8},
               {card:"9", suit: :spades, value:9},
               {card:"10", suit: :spades, value:10},
               {card:"J", suit: :spades, value:10},
               {card:"Q", suit: :spades, value:10},
               {card:"K", suit: :spades, value:10},
               {card:"A", suit: :hearts, value:11},
               {card:"2", suit: :hearts, value:2},
               {card:"3", suit: :hearts, value:3},
               {card:"4", suit: :hearts, value:4},
               {card:"5", suit: :hearts, value:5},
               {card:"6", suit: :hearts, value:6},
               {card:"7", suit: :hearts, value:7},
               {card:"8", suit: :hearts, value:8},
               {card:"9", suit: :hearts, value:9},
               {card:"10", suit: :hearts, value:10},
               {card:"J", suit: :hearts, value:10},
               {card:"Q", suit: :hearts, value:10},
               {card:"K", suit: :hearts, value:10},
               {card:"A", suit: :diamonds, value:11},
               {card:"2", suit: :diamonds, value:2},
               {card:"3", suit: :diamonds, value:3},
               {card:"4", suit: :diamonds, value:4},
               {card:"5", suit: :diamonds, value:5},
               {card:"6", suit: :diamonds, value:6},
               {card:"7", suit: :diamonds, value:7},
               {card:"8", suit: :diamonds, value:8},
               {card:"9", suit: :diamonds, value:9},
               {card:"10", suit: :diamonds, value:10},
               {card:"J", suit: :diamonds, value:10},
               {card:"Q", suit: :diamonds, value:10},
               {card:"K", suit: :diamonds, value:10},
               {card:"A", suit: :clubs, value:11},
               {card:"2", suit: :clubs, value:2},
               {card:"3", suit: :clubs, value:3},
               {card:"4", suit: :clubs, value:4},
               {card:"5", suit: :clubs, value:5},
               {card:"6", suit: :clubs, value:6},
               {card:"7", suit: :clubs, value:7},
               {card:"8", suit: :clubs, value:8},
               {card:"9", suit: :clubs, value:9},
               {card:"10", suit: :clubs, value:10},
               {card:"J", suit: :clubs, value:10},
               {card:"Q", suit: :clubs, value:10},
               {card:"K", suit: :clubs, value:10}]

#check is there is an "Ace" 

def check_a?(hand)
  hand.any? {|card| card[:card] == "A"}
end

#check is there is an "Jack" 

def check_j?(hand)
  hand.any? {|card| card[:card] == "J"}
end

#check if is blackjack

def check_blackjack?(hand)
  blackjack = false
  if hand.count == 2
    hand.each do |card|
    blackjack = true if check_a?(hand) && check_j?(hand)
     end
  end
  return blackjack
end

#calculate the value of the hand 

def calculate(hand)
  hand_value = hand.map {|s| s[:value]}.reduce(0, :+)
end

#turn a card

def turn_card(player,card_deck)
  card = card_deck.shift
  puts "Dealer turn #{card[:card]} of #{card[:suit]}"
  player << card
end

#shuffle the card

def shuffle(card_deck)
  card_deck.shuffle!
  (1..10).each do |pause|
    sleep 0.1
    print "*" 
  end
end

#print the card

def print_card(deck)
   deck.each{|card| puts "#{card[:card]} of #{card[:suit]}" } 
end

puts "Welcome to BlackJack. To play I need to know your name"
sleep 1
puts "What's your name? Type it"
player_name = gets.chomp
puts

puts "Hello #{player_name}. I hope you know the BlackJack rules. Do you want to play with single deck or with a shoe (4 decks)?"
puts
puts "1) Single deck game"
puts "2) 4 decks of cards"
game_type = gets.chomp

#build the match deck

if game_type == 1
  card_deck = single_deck
else
  card_deck = single_deck * 4
end

puts "Good, I'm shuffling the cards"

shuffle(card_deck)

puts "Card shuffled, here are your cards..."

#give the cards

player_hand = card_deck.shift(2)
dealer_hand = card_deck.shift(2)


while true

dealer_hand_value = calculate(dealer_hand)
player_hand_value = calculate(player_hand)

puts "You have these cards: "
puts
print_card(player_hand)
puts
puts "You have #{player_hand_value}"
puts
puts "Dealer has these card:"
puts
print_card(dealer_hand)
puts
puts "Dealer has #{dealer_hand_value}"
puts


if check_blackjack?(player_hand)
  puts "Wow, you have BlackJack, you win"
  break
end

if check_blackjack?(dealer_hand)
  puts "I'm sorry, dealer has BlackJack. He win"
  break
end

puts "The value of your card is #{player_hand_value}"
puts
puts "The dealer show #{dealer_hand[0][:value]} (real value #{dealer_hand_value} "


puts "What do you want do do?"
puts "1) Stay"
puts "2) Hit"

choice = gets.chomp

  if choice == "2"
    
    puts "The value of your card is #{player_hand_value}. You choose to turn card"
    turn_card(player_hand, card_deck)
    sleep 1
    player_hand_value = calculate(player_hand)
    if player_hand_value > 21
      puts "Hai sballato, hai perso"
      break
    end
    puts "You have #{player_hand_value}. What do you want to do?"
 
  elsif choice == "1"
    

    while dealer_hand_value < 17

      puts "The dealer has #{dealer_hand_value} and must turn another card"
      turn_card(dealer_hand,card_deck)
     
      dealer_hand_value = calculate(dealer_hand)
      
      sleep 1
    end

    if dealer_hand_value.between?(17,21)
       puts "Dealer has #{dealer_hand_value} and must stay"
       sleep 1
       if dealer_hand_value > player_hand_value
        puts "dealer win with #{dealer_hand_value} against #{player_hand_value}"
        break
       else 
        puts "player win with #{player_hand_value} against #{dealer_hand_value}"
        break
       end
    else 
      puts "Dealer has #{dealer_hand_value} e sballa, you win"
      break
    end

  else 
    puts "You have to choose between stay and hit"
  end

end





