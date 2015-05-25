require 'test_helper'

class TestPitchImplementation < MiniTest::Test
  def setup
    @pitch_note_B4      = MusicTheory::Note.new(pitch: Pitch.new(:B, 4), duration: 1.0, distort: false)
    @frequency_note_B4  = MusicTheory::Note.new(frequency: 493.883, duration: 1.0, distort: false)
    @pitch_note_Gf7     = MusicTheory::Note.new(pitch: Pitch.new(:Gf, 7), duration: 2.0, distort: false)
    @frequency_note_Gf7 = MusicTheory::Note.new(frequency: 2959.955, duration: 2.0, distort: false)
    @default_note       = MusicTheory::Note.new
  end

  def test_note_with_pitch_input_evaluates_to_correct_frequency
    assert_equal @pitch_note_B4.frequency, @frequency_note_B4.frequency
    assert_equal @pitch_note_Gf7.frequency, @frequency_note_Gf7.frequency
  end

  def test_note_with_pitch_input_does_not_use_default_frequency
    refute_equal @pitch_note_B4.frequency, @default_note.frequency
    refute_equal @pitch_note_Gf7.frequency, @default_note.frequency
  end
end
