require './hangman'
require 'pry'


def start_game player
  puts "Would you like to"
  puts "1) guess the word"
  puts "2) pick the word"

  case selection = gets.chomp
  when "1"
    Hangman.new(player, AI.new)
  when "2"
    Hangman.new(AI.new, player)
  else
    puts "What does '#{selection}' mean?"
    start_game player
  end
end

puts "Welcome to hangman!"
player = Human.new
g      = start_game player
g.make_moves until g.over?

if g.guesser == player
  if g.won?
    puts "You won!"
  else
    puts "You lost! The word was #{g.word}"
  end

else
  if g.won?
    puts "The computer won!"
  else
    puts "You have defeated the machine!"
  end
end
