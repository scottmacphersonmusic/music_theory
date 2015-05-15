require 'test_helper'

class TestHarmonize < MiniTest::Test
  def setup
    samples_one    = [0, 1, 0, -1]
    samples_two    = [1, 0, -1, 0]
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

  def test_memoize_samples
    samples_one = @subject.samples
    samples_two = @subject.samples

    assert_objects_identical(samples_one, samples_two)
  end

  private

  def assert_objects_identical(*objects)
    id = objects[0].object_id
    test = true

    objects.each do |obj|
      test = false unless obj.object_id == id
    end

    assert(test, "Expected objects be identical #{objects}")
  end
end
