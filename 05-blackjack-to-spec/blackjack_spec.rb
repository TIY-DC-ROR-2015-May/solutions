require './blackjack'
require 'minitest/autorun'

class TestCard < Minitest::Test
  def test_number_card_value
    2.upto(10) do |x|
      card = Card.new(x, :S)
      assert_equal card.value, x
    end
  end

  def test_face_card_value
    [:K, :Q, :J].each do |rank|
      card = Card.new(rank, :H)
      assert_equal card.value, 10
    end
  end

  def test_ace_value
    card = Card.new(:A, :D)
    assert_equal card.value, 1
  end
end

class TestDeck < Minitest::Test
  def test_counting_cards
    deck = Deck.new
    assert_equal deck.cards.count, 52
  end

  def test_counting_draws
    deck = Deck.new
    deck.draw
    assert_equal deck.cards.count, 51
  end

  def test_tracking_draws
    deck = Deck.new
    drawn_card = deck.draw
    assert_equal deck.cards.count, 51
    refute_includes deck.cards, drawn_card
    assert_includes deck.drawn, drawn_card
  end
end

class TestHand < Minitest::Test
  def test_hand_value_with_number_cards
    hand = Hand.new
    hand.add(Card.new(9, :H), Card.new(7, :S))
    assert_equal hand.value, 16

    hand.add(Card.new(4, :D))
    assert_equal hand.value, 20
  end

  def test_hand_value_with_face_cards
    hand = Hand.new
    hand.add(Card.new(9, :H), Card.new(:K, :S))
    assert_equal hand.value, 19
  end

  def test_hand_value_with_aces
    hand = Hand.new
    hand.add(Card.new(:A, :H), Card.new(:K, :S))
    assert_equal hand.value, 21

    hand.add(Card.new(5, :S))
    assert_equal hand.value, 16
  end

  def test_busting
    hand = Hand.new
    hand.add(Card.new(6, :H), Card.new(:K, :S), Card.new(9, :H))
    assert hand.busted?
  end

  def test_blackjack
    hand = Hand.new
    hand.add(Card.new(:A, :H), Card.new(:K, :S))
    assert hand.blackjack?
  end

  def test_hand_as_string
    hand = Hand.new
    hand.add(Card.new(:A, :H), Card.new(:K, :S))
    hand.add(Card.new(5, :S))
    assert_equal hand.to_s, 'AH, KS, 5S'
  end
end
