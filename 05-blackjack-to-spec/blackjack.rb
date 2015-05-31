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
    @cards.shuffle!
  end

  def draw
    card = @cards.pop
    @drawn.push card
    card
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
end
