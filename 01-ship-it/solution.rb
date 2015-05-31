# 1. Copy this file from the course notes repo into a new repository
# 2. Run `ruby triangle_test.rb`. You should see 6 error messages.
# 3. Implement the Triangle class until all 6 tests are passing.
require "minitest/autorun"

class Triangle
  def initialize a,b,c
    # This block is only needed for HARD MODE
    [a,b,c].each do |side|
      unless side.is_a?(Numeric) && side > 0
        raise "#{side} is not a valid sidelength"
      end
    end

    @a,@b,@c = a,b,c
  end

  def kind
    if @a == @b && @b == @c
      :equilateral
    elsif @a == @b || @b == @c || @a == @c
      :isosceles
    else
      :scalene
    end
  end

  def perimeter
    @a + @b + @c
  end
end

class TestMeme < Minitest::Test
  def test_equilateral
    t = Triangle.new(5,5,5)
    assert_equal :equilateral, t.kind
  end

  def test_isosceles
    s = Triangle.new(2,2,3)
    assert_equal :isosceles, s.kind
  end

  def test_other_isosceles
    t = Triangle.new 3,4,3
    assert_equal :isosceles, t.kind
  end

  def test_scalene
    t = Triangle.new 6,7,8
    assert_equal :scalene, t.kind
  end

  def test_perimeter_right
    t = Triangle.new(3,4,5)
    assert_equal 12, t.perimeter
  end

  def test_perimeter_eq
    t = Triangle.new 10,20,30
    assert_equal 60, t.perimeter
  end

  # HARD MODE
  def test_invalid_triangles
    assert_raises RuntimeError do
      Triangle.new 0,1,2
    end
    assert_raises RuntimeError do
      Triangle.new -1,-2,-3
    end
    assert_raises RuntimeError do
      Triangle.new "some text", {foo: 2}, :apple
    end
  end
end
