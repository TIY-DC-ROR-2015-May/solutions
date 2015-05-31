class Human
  def pick_word
    print "Pick a word to guess > "
    gets.chomp
  end

  def make_guess game
    print "Your guess > "
    guess = gets.chomp
    game.record_guess guess
  end
end


class AI
  def pick_word
    Hangman::Dictionary.sample
  end

  def make_guess game
    # Idea: count up letter frequencies of words in the dictionary which
    #   match the board so far, and guess the most frequent
    counts = {}
    Hangman::Dictionary.each do |word|
      next unless word_matches_board? word, game.board

      word.chars.each do |letter|
        next if game.guessed.include? letter
        counts[letter] ||= 0
        counts[letter]  += 1
      end
    end

    guess = counts.max_by { |letter, count| count }.first
    puts "Guessing '#{guess}'"
    guess
  end

  def word_matches_board? word, board
    return false unless word.length == board.length
    board.chars.each_index.all? { |i| board[i] == "_" || board[i] == word[i] }
  end
end


class Hangman
  Dictionary = File.open("/usr/share/dict/words").each_line.
    map    { |w| w.chomp }.
    select { |w| (3..7).cover?(w.length) && w == w.downcase }

  attr_reader :word, :guesses_left, :guessed, :guesser

  def initialize guesser, picker
    @guesser = guesser
    @word    = picker.pick_word
    raise "Unrecognized word" unless Dictionary.include?(@word)

    @guesses_left = 8
    @guessed      = []
  end

  def make_moves
    puts board
    puts "#{guesses_left} guesses left | missed #{misses.join ','}"

    guess = @guesser.make_guess self
    record_guess guess
  end

  def over?
    won? || lost?
  end

  def won?
    word.chars.all? { |l| @guessed.include?(l) }
  end

  def lost?
    guesses_left <= 0
  end

  def board
    squares = []
    word.chars.each do |l|
      if @guessed.include? l
        squares.push l
      else
        squares.push "_"
      end
    end
    squares.join ""
  end

  def misses
    @guessed - word.chars
  end

  def record_guess letter
    @guessed.push letter
    unless word.chars.include?(letter)
      @guesses_left -= 1
    end
  end
end
