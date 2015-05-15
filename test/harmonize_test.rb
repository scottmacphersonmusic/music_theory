require 'test_helper'

class TestHarmonize < MiniTest::Test
  def setup
    samples_one = [0, 1, 0, -1]
    samples_two = [1, 0, -1, 0]
    @samples_three = [-1, 0, 1, 0, -1]

    @subject = MusicTheory::Harmonize.new(samples_one, samples_two, @samples_three)
  end

  def test_samples_not_clipping
    samples = @subject.samples
    max = samples.map {|s| s.abs }.max
    assert_equal 1.0, max
  end

  def test_duration_matches_longest_input
    result_len = @subject.samples.length
    assert_equal @samples_three.length, result_len
  end
end
