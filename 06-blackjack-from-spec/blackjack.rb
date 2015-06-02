class Card
  attr_reader :rank, :suit

  def initialize rank, suit
    @rank, @suit = rank, suit
  end

  def value
    case rank
    when :J, :Q, :K
      10
    when :A
      1
    else
      rank
    end
  end

  def to_s
    "#{@rank}#{@suit}"
  end
end

class Deck
  attr_reader :cards, :drawn

  Ranks = (2..10).to_a + [:J, :Q, :K, :A]
  Suits = [:S, :D, :H, :C]

  def initialize
    @cards, @drawn = [], []
    Ranks.each do |rank|
      Suits.each do |suit|
        @cards.push Card.new(rank, suit)
      end
    end
    shuffle!
  end

  def draw
    card = @cards.pop
    @drawn.push card
    card
  end

  def shuffle!
    @cards.shuffle!
  end

  def low?
    @cards.count < 10
  end
end

class Hand
  def initialize
    @cards = []
  end

  def add *cards
    @cards += cards
  end

  def value
    base = 0
    @cards.each do |card|
      base += card.value
    end

    if base <= 11 && @cards.any? { |card| card.rank == :A }
      base + 10
    else
      base
    end
  end

  def busted?
    value > 21
  end

  def blackjack?
    value == 21 && @cards.count == 2
  end

  def to_s
    @cards.map { |card| card.to_s }.join ", "
  end

  def first_card
    @cards.first
  end
end


class Player
  attr_reader :hand, :money

  def initialize
    @money = 500
  end

  def new_hand deck
    @hand = Hand.new
    2.times do
      draw_from deck
    end
  end

  def draw_from deck
    hand.add deck.draw
  end

  def want_to_continue?
    print "Would you like to continue? (y/n) "
    input = gets.chomp
    if input == "y"
      true
    elsif input == "n"
      false
    else
      puts "Invalid selection: #{input}"
      want_to_continue?
    end
  end

  def take_bet
    print "How much would you like to bet? (1-#{money}) "
    input = gets.chomp.to_i
    if (1..money).cover?(input)
      input
    else
      puts "Invalid amount: #{input}"
      take_bet
    end
  end

  def wins! bet
    @money += bet
  end

  def loses! bet
    @money -= bet
  end

  def broke?
    money.zero?
  end

  def hit? opponent
    if hand.blackjack?
      puts "Blackjack!"
      false
    elsif hand.busted?
      puts "Busted!"
      false
    else
      want_to_hit? opponent
    end
  end

  def want_to_hit? opponent
    puts "Your hand: #{hand} (#{hand.value})"
    puts "Dealer showing: #{opponent.hand.first_card}"
    print "Hit or stand? (h/s) "
    input = gets.chomp
    if input == "h"
      true
    elsif input == "s"
      false
    else
      puts "Invalid input: #{input}"
      want_to_hit? dealer
    end
  end
end

class Dealer < Player
  def want_to_hit? opponent
    hand.value < 17
  end
end
