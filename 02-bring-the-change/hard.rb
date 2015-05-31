require 'minitest/autorun'

class Register
  class Impossible < StandardError
  end

  def initialize contents={}
    @contents = contents
  end

  def change dollars
    cents = (dollars * 100).to_i
    left  = cents

    result = []
    @contents.each do |coin_size, remaining|
      take = left / coin_size
      take = remaining if take > remaining
      result.push take

      @contents[coin_size] -= take
      left -= take * coin_size
    end

    if left > 0
      raise Impossible
    end
    return result
  end
end

class RegisterTest < Minitest::Test
  def test_it_can_run_out_of_quarters
    r = Register.new 25 => 1, 10 => 1, 5 => 5, 1 => 100
    assert_equal [1,1,5,10], r.change(0.70)
  end

  def test_it_can_run_out_of_everything
    r = Register.new 25 => 1, 10 => 1, 5 => 1, 1 => 1
    assert_equal [1,1,1,1], r.change(0.41)
    assert_raises Register::Impossible do
      r.change(0.41)
    end
  end

  def test_it_can_phase_out_the_penny
    r = Register.new 33 => 100, 25 => 100, 10 => 100, 5 => 100
    assert_equal [1,1,0,1], r.change(0.63)
  end

  def test_it_might_have_trouble_without_a_penny
    r = Register.new 33 => 100, 25 => 100, 10 => 100, 5 => 100
    assert_raises Register::Impossible do
      r.change 0.40
    end
  end
end
