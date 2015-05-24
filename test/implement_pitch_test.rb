require 'test_helper'

class TestPitchImplementation < MiniTest::Test
  def setup
    @pitch_object_note = MusicTheory::Note.new(pitch:  Pitch.new(:B, 4), duration: 1.0, distort: false)
    @frequency_note    = MusicTheory::Note.new(frequency: 493.883, duration: 1.0, distort: false)
    @default_note      = MusicTheory::Note.new
  end

  def test_note_accepts_pitch_object_input
    refute_equal @pitch_object_note.frequency, @default_note.frequency
    assert_equal @pitch_object_note.frequency, @frequency_note.frequency
  end
end
