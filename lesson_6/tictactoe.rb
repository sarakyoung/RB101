require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[2, 5, 8], [1, 4, 7], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]
FIRST_MOVE = 'choose'
WINNING_SCORE = 2

def prompt(msg)
  puts "=> #{msg}"
end

def assign_first_player(first_move)
  first_player = " "
  if first_move == 'choose'
    loop do
      prompt "Who would you like to move first? (player or computer)"
      first_player = gets.chomp.downcase
      break if first_player == 'player' || first_player == 'computer'
      prompt 'Please enter a valid response (player or computer)'
    end
  else
    first_player = first_move
  end
  first_player
end

def display_score(scores_hash)
  scores_hash.each { |side, score| puts "#{side.upcase}: #{score}" }
  true
end

def display_header(p_marker, c_marker, win_score, scores)
  prompt "You're #{p_marker}."
  prompt "Computer is #{c_marker}."
  prompt "#{win_score} points wins"
  display_score(scores)
end

# rubocop:disable Metrics/AbcSize Metrics/MethodLength
def display_board(brd, scores)
  system 'clear'
  display_header(PLAYER_MARKER, COMPUTER_MARKER, WINNING_SCORE, scores)
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize Metrics/MethodLength

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(arr, punc=',', conj = 'or')
  if arr.length == 0
    ''
  elsif arr.length == 1
    arr[0]
  else
    arr.first(arr.length - 1).join(punc + ' ') + ' ' + conj + ' ' + arr.last.to_s
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd), ',')}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice"
  end
  brd[square] = PLAYER_MARKER
end

def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select{|k,v| line.include?(k) && v == INITIAL_MARKER}.keys.first
  else
    nil
  end
end

def computer_places_piece!(brd)
  square = nil
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, PLAYER_MARKER)
    break if square
  end

  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, COMPUTER_MARKER)
    break if square
  end
  
  if brd[5] == ' '
    square = 5
  elsif square.nil?
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def place_piece!(current_player, brd)
  if current_player == 'player'
    player_places_piece!(brd)
  else
    computer_places_piece!(brd)
  end
end

def switch_turns(current_player)
  return 'computer' if current_player == 'player'
  'player'
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(line[0], line[1], line[2]).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(line[0], line[1], line[2]).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def update_score(winner, scores)
  if winner == 'Computer'
    scores[:computer] += 1
  else
    scores[:player] += 1
  end
  scores
end

def game_winner(scores)
  scores[:computer] == WINNING_SCORE ? 'Computer' : 'Player'
end

def display_final_results(scores)
  system 'clear'
  prompt "Final Score:"
  display_score(scores)
  prompt "!!#{game_winner(scores)} won the game!!"
end

# -----------------------------------------------------------------------

loop do                             # game of # rounds
  scores = { player: 0, computer: 0 }
  first_player = assign_first_player(FIRST_MOVE)

  loop do                           # score keeping
    board = initialize_board
    current_player = first_player

    loop do                         # each turn
      display_board(board, scores)
      place_piece!(current_player, board)
      break if someone_won?(board) || board_full?(board)
      current_player = switch_turns(current_player)
    end

    display_board(board, scores)

    if someone_won?(board)
      prompt "#{detect_winner(board)} won this round!"
      update_score(detect_winner(board), scores)
    else
      prompt "It's a tie!"
    end

    break if scores.values.include?(WINNING_SCORE)

    prompt 'Press enter to play next round!'
    gets
  end

  display_final_results(scores)

  prompt "Play again? (y or n?)?"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing tic tac toe! Goodbye."
