require 'test_helper'

class TestNote < MiniTest::Test
  def setup
    @test_samples = eval(File.read('test/fixtures/note_samples_array'))
    @basic_note = MusicTheory::Note.new
    @note_220 = MusicTheory::Note.new(frequency: 220)
    @distorted_note = MusicTheory::Note.new(distort: true)
  end

  def test_samples_are_identical
    assert_equal @test_samples, @basic_note.samples
  end

  def test_number_of_samples_match
    assert_equal @test_samples.length, @basic_note.samples.length
    assert_equal @test_samples.length, @note_220.samples.length
    assert_equal @test_samples.length, @distorted_note.samples.length
  end
end
