CARD_TYPES = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
SUITS = %w(C S H D)
CARD_VALUES =
  {
    '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
    '7' => 7, '8' => 8, '9' => 9, '10' => 10, 'Jack' => 10,
    'Queen' => 10, 'King' => 10, 'Ace' => 0
  }
MAX_TOTAL = 21
DEALER_HIT_LIMIT = 17
ROUNDS_TO_WIN = 5

def prompt(text)
  puts "--> #{text}"
end

# rubocop:disable Metrics/MethodLength
def show_rules
  prompt "You will be playing against the dealer."
  sleep(1)
  prompt "The goal of the game is to get as close to " \
          "#{MAX_TOTAL} as possible, without going over."
  sleep(1)
  prompt "To add another card to your deck, select 'hit'. " \
          "To complete your turn, select 'stay."
  sleep(1)
  prompt "If either players exceeds #{MAX_TOTAL}, it's a 'bust' and they lose."
  sleep(1)
  prompt "If no one busts, the player with the higher hand value wins."
  sleep(1)
  prompt "If the hand values are the same, the dealer wins."
  sleep(1)
  prompt "#{ROUNDS_TO_WIN} rounds wins the game."
  sleep(1)
  prompt "Press Enter when you are ready to play!"
  gets
end
# rubocop:enable Metrics/MethodLength

def loading_message(string, num)
  print string
  num.times do
    sleep(0.5)
    print '.'
  end
  puts ''
end

def initialize_deck
  SUITS.product(CARD_TYPES)
end

def draw_card(deck)
  drawn_card = deck.sample
  deck.delete(drawn_card)
end

def deal_card(deck, hand)
  hand << draw_card(deck)
end

def starting_deal(deck, player_hand, dealer_hand)
  2.times do
    deal_card(deck, player_hand)
    deal_card(deck, dealer_hand)
  end
end

def list_cards(hand)
  cards = []
  hand.each { |card| cards << card[1] }
  last_card = cards.pop
  cards.join(', ') + ' and ' + last_card
end

def valid_response
  answer = ''
  loop do
    answer = gets.chomp
    break if ['y', 'n'].include?(answer)
    prompt "Please enter a valid response. 'y' or 'n'"
  end
  answer
end

def show_hands(player_hand, dealer_hand)
  prompt("Dealer has: #{dealer_hand[1][1]} and unknown card")
  prompt("You have: #{list_cards(player_hand)}")
  prompt("The value of your cards is #{calculate_hand_value(player_hand)}")
end

def ace_value(sum)
  ace_value = 1
  ace_value += 10 if sum <= 10
  ace_value
end

def calculate_hand_value(hand)
  sum = 0
  hand.each do |card|
    sum += CARD_VALUES[card[1]]
  end
  sum += ace_value(sum) if hand.flatten.any?('Ace')
  sum
end

def player_input
  answer = ' '
  puts ' '
  prompt "Hit or Stay? 'h' or 's'"
  loop do
    answer = gets.chomp.downcase
    break if ['h', 's', 'hit', 'stay'].include?(answer)
    prompt "Please enter a valid response. ('h' for Hit or 's' for Stay)."
  end
  answer
end

def bust?(total)
  total > MAX_TOTAL
end

def list_cards_values(player_hand, player_total, dealer_hand, dealer_total)
  puts "Your hand was #{list_cards(player_hand)}" \
      " with a total value of #{player_total}."
  puts "Dealer's hand was #{list_cards(dealer_hand)}" \
      " with a total value of #{dealer_total}."
  puts ' '
end

def determine_winner(player_total, dealer_total)
  if bust?(player_total)
    'dealer'
  elsif bust?(dealer_total)
    'player'
  elsif player_total < dealer_total
    'dealer'
  elsif player_total > dealer_total
    'player'
  else
    'tie'
  end
end

def declare_winner(winner)
  case (winner)
  when 'player'
    prompt "You won this round!"
  when 'dealer'
    prompt "Dealer won this round!"
  when 'tie'
    prompt "It's a tie this round! Dealer gets a point."
  end
end

def update_score(scores, winner)
  if winner == 'player'
    scores['player'] += 1
  else
    scores['dealer'] += 1
  end
end

def display_score(scores)
  puts ' '
  puts "Your score: #{scores['player']}"
  puts "Dealer score: #{scores['dealer']}"
  puts "#{ROUNDS_TO_WIN} points wins the game."
end

def grand_winner?(scores)
  scores['player'] == ROUNDS_TO_WIN || scores['dealer'] == ROUNDS_TO_WIN
end

def declare_grand_winner(scores)
  puts ''
  puts '================='
  if scores['player'] == ROUNDS_TO_WIN
    puts "!!!You won the game!!!"
  elsif scores['dealer'] == ROUNDS_TO_WIN
    puts "Dealer won the game!"
  end
  puts '================='
  puts ''
end

def play_again?
  prompt "Would you like to play again? (y/n)"
  answer = valid_response
  answer == 'y'
end

system('clear')
prompt "Welcome to Twenty-One!"
prompt "Would you like to learn the rules of the game? (y/n)"
answer = valid_response
show_rules if answer == 'y'

loop do
  scores = { 'player' => 0, 'dealer' => 0 }
  loop do
    system('clear')

    deck = initialize_deck
    player_hand = []
    dealer_hand = []

    starting_deal(deck, player_hand, dealer_hand)

    player_total = calculate_hand_value(player_hand)
    dealer_total = calculate_hand_value(dealer_hand)

    prompt "Let's get started!"
    sleep(0.5)
    loading_message('Dealing cards', 4)

    system('clear')

    # player turn
    loop do
      show_hands(player_hand, dealer_hand)
      break if player_input.start_with?('s')
      deal_card(deck, player_hand)
      player_total = calculate_hand_value(player_hand)
      if bust?(player_total)
        puts "You busted!"
        sleep(1)
        break
      end
      system('clear')
    end

    # dealer turn
    puts ' '
    unless bust?(player_total)
      loading_message("Dealer playing turn", 3)
      puts ' '
      loop do
        break if dealer_total >= DEALER_HIT_LIMIT
        deal_card(deck, dealer_hand)
        dealer_total = calculate_hand_value(dealer_hand)
      end
      prompt "Dealer busted!" if bust?(dealer_total)
    end

    list_cards_values(player_hand, player_total, dealer_hand, dealer_total)

    winner = determine_winner(player_total, dealer_total)
    declare_winner(winner)
    update_score(scores, winner)

    display_score(scores)

    break if grand_winner?(scores)

    puts ' '
    puts "Press enter to play next round."
    gets
  end
  sleep(1)
  declare_grand_winner(scores)
  break unless play_again?
end

prompt 'Thank you for playing!'
