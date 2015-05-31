require 'minitest/autorun'

class Register
  def change dollars
    cents = (dollars * 100).to_i
    quarters, leftover = change_one_coin cents,    25
    dimes,    leftover = change_one_coin leftover, 10
    nickels,  leftover = change_one_coin leftover,  5
    pennies,  leftover = change_one_coin leftover,  1
    [quarters, dimes, nickels, pennies]
  end

  def change_one_coin amount, coin_size
    # Alternatively: amount.divmod coin_size
    number_of_coins = amount / coin_size # Integer division
    remainder       = amount - (number_of_coins * coin_size)
    return [number_of_coins, remainder]
  end
end

class RegisterTest < Minitest::Test
  def test_it_works
    r = Register.new
    assert_equal [3,2,0,4], r.change(0.99)
  end
end
