require 'test_helper'

class TestNote < MiniTest::Test
  def setup
    @pitch_object_note = MusicTheory::Note.new(frequency: Pitch.new(:B, 4), duration: 1.0, distort: false)
    @frequency_note    = MusicTheory::Note.new(frequency: 493.883, duration: 1.0, distort: false)
  end

  def test_note_accepts_pitch_object_input
    # assert_equal @pitch_object_note.sine_wave_cycle, @frequency_note.sine_wave_cycle
    puts @pitch_object_note.class
    puts @frequency_note.class
  end
end
