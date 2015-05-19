require 'test_helper'

class TestNote < MiniTest::Test
  def setup
    @test_samples = eval(File.read('test/fixtures/note_samples_array'))
    @basic_note = MusicTheory::Note.new
    @note_220 = MusicTheory::Note.new(frequency: 220)
    @distorted_note = MusicTheory::Note.new(distort: true)
  end

  def test_samples_are_identical
    assert compare_sample_arrays(@test_samples, @basic_note.samples) < (0.1 * (10 ** -10))
  end

  def test_number_of_samples_match
    assert_equal @test_samples.length, @basic_note.samples.length
    assert_equal @test_samples.length, @note_220.samples.length
    assert_equal @test_samples.length, @distorted_note.samples.length
  end

  def test_number_of_frames_matches_number_of_samples
    assert_equal @basic_note.total_frames, @basic_note.samples.length
    assert_equal @note_220.total_frames, @note_220.samples.length
    assert_equal @distorted_note.total_frames, @distorted_note.samples.length
  end

  def test_amplitude_range
    # this doesn't look very DRY - private helper method?
    # helper should take care of array examination and return one assertion
    @basic_note.samples.each do |sample|
      assert sample.abs <= 1
    end
    @note_220.samples.each do |sample|
      assert sample.abs <= 1
    end
    @distorted_note.samples.each do |sample|
      assert sample.abs <= 1
    end
  end

  private

  def compare_sample_arrays(array_1, array_2)
    diff = 0
    zipped = array_1.zip(array_2)
    zipped.each do |item|
      diff += (item[0] - item[1]).abs
    end
    diff
  end
end
