require 'test_helper'

class TestPitch < MiniTest::Test
  def setup
    @A4  = Pitch.new :a,   4
    @Ds2 = Pitch.new 'dS', 2
    @Gf5 = Pitch.new :Gf,  5
  end

  def test_frequency
    assert_equal @A4.frequency,  440.0
    assert_equal @Ds2.frequency, 77.782
    assert_equal @Gf5.frequency, 739.989
  end

  def test_to_s
    assert_equal @A4.to_s,  "A 4"
    assert_equal @Ds2.to_s, "D# 2"
    assert_equal @Gf5.to_s, "Gb 5"
  end
end
