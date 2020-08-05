VALID_CHOICES = %w(rock paper scissors lizard spock)

WINNING_PLAY = { 'rock' => ['scissors', 'lizard'],
                 'paper' => ['rock', 'spock'],
                 'scissors' => ['paper', 'lizard'],
                 'lizard' => ['paper', 'spock'],
                 'spock' => ['rock', 'scissors'] }

WINNING_SCORE = 5

def prompt(message)
  puts "=> #{message}"
end

def get_user_input
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}.")
    prompt("(Optional: Type 'r' for rock, 'p' for paper, " \
     "'sc' for scissors, 'l' for lizard, 'sp' for spock.)")
    choice = gets.chomp.downcase
    choice = convert_choice(choice)

    return choice if VALID_CHOICES.include?(choice)
    prompt("That's not a valid choice. Try again.")
  end
end

def convert_choice(entry)
  case entry
  when 'r' then 'rock'
  when 'p' then 'paper'
  when 'sc' then 'scissors'
  when 'l' then 'lizard'
  when 'sp' then 'spock'
  else entry
  end
end

def win?(first, second)
  WINNING_PLAY[first].include?(second)
end

def display_result(player, computer)
  if win?(player, computer)
    prompt("You won this round!")
  elsif win?(computer, player)
    prompt("Computer won this round!")
  else
    prompt("This round is a tie!")
  end
end

def calculate_score(player, computer, scores)
  if win?(player, computer)
    scores[:player] += 1
  elsif win?(computer, player)
    scores[:computer] += 1
  else
    scores[:player] += 1
    scores[:computer] += 1
  end
end

def display_score(scores)
  puts "--- Player: #{scores[:player]}"
  puts "--- Computer: #{scores[:computer]}"
end

def display_winner(scores)
  if scores[:computer] == WINNING_SCORE
    puts '!!Computer won!!'
  elsif scores[:player] == WINNING_SCORE
    puts '!!You won!!'
  else
    puts '!!You tied!!'
  end
end

def match_over?(scores)
  if scores[:player] == WINNING_SCORE || scores[:computer] == WINNING_SCORE
    display_winner(scores)
    true
  end
end

def play_again?
  loop do
    prompt("Would you like to play again? (Y/N)")
    answer = gets.chomp.downcase
    if answer == 'y'
      return true
    elsif answer == 'n'
      return false
    end
  end
end

loop do
  scores = { player: 0, computer: 0 }
  round_count = 0
  prompt("Win #{WINNING_SCORE} rounds to beat the game!")
  loop do
    round_count += 1
    choice = get_user_input

    computer_choice = VALID_CHOICES.sample

    system('clear')

    prompt("Round #{round_count}: You chose #{choice}; " \
      "Computer chose #{computer_choice}")

    display_result(choice, computer_choice)
    calculate_score(choice, computer_choice, scores)
    display_score(scores)

    break if match_over?(scores)
  end

  break unless play_again?
end

prompt('Thank you for playing. Goodbye!')
