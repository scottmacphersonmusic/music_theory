require 'test_helper'

class TestHarmonize < MiniTest::Test
  def setup
    samples_one = [0, 1, 0, -1]
    samples_two = [1, 0, -1, 0]

    @subject = MusicTheory::Harmonize.new(samples_one, samples_two)
  end

  def test_samples_not_clipping
    samples = @subject.samples
    max = samples.map {|s| s.abs }.max
    assert_equal 1.0, max
  end
end
