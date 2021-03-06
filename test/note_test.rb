require 'test_helper'

class TestNote < MiniTest::Test
  def setup
    @test_samples = eval(File.read('test/fixtures/note_samples_array'))
    @basic_note     = MusicTheory::Note.new(frequency: 440, duration: 1.0, distort: false)
    @note_220       = MusicTheory::Note.new(frequency: 220, duration: 1.0, distort: false)
    @distorted_note = MusicTheory::Note.new(frequency: 440, duration: 1.0, distort: true)
  end

  DIFF_THRESHOLD = 1.0e-12

  def test_samples_are_identical
    assert sample_arrays_diff(@test_samples, @basic_note.samples) < DIFF_THRESHOLD
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
    assert @basic_note.samples.all? { |sample| sample.abs <= 1 }
    assert @note_220.samples.all? { |sample| sample.abs <= 1 }
    assert @distorted_note.samples.all? { |sample| sample.abs <= 1 }
  end

  private

  def sample_arrays_diff(array_1, array_2)
    diff = 0
    array_1.zip(array_2) do |sample_1, sample_2|
      diff += (sample_1 - sample_2).abs
    end
    diff
  end
end
