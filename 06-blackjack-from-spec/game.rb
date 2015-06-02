require "./blackjack"

class Blackjack
  attr_reader :player, :dealer, :deck

  def initialize
    @deck   = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def play_round
    deck.reshuffle if deck.low?

    player.new_hand deck
    dealer.new_hand deck

    bet = player.take_bet

    while player.hit?(dealer)
      player.draw_from deck
    end

    unless player.hand.blackjack? || player.hand.busted?
      while dealer.hit?(player)
        dealer.draw_from deck
      end
      puts "Dealer has: #{dealer.hand} (#{dealer.hand.value})"
    end

    if winner == player
      player.wins! bet
      puts "You win! You now have $#{player.money}"
    elsif winner == dealer
      player.loses! bet
      puts "You lose! You now have $#{player.money}"
    else
      puts "It's a push"
    end
  end

  def winner
    if player.hand.busted?
      dealer
    elsif dealer.hand.busted?
      player
    elsif player.hand.value > dealer.hand.value
      player
    elsif dealer.hand.value > player.hand.value
      dealer
    end
  end
end


game = Blackjack.new
loop do
  game.play_round

  if game.player.broke?
    puts "Get out!"
    break
  end

  break unless game.player.want_to_continue?
end
