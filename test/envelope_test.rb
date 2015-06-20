require 'test_helper'

class TestEnvelope < MiniTest::Test
  def setup
    duration = 3.0
    @envelope_note = MusicTheory::Note.new(pitch: Pitch.new(:A, 4),
                                           duration: duration,
                                           envelope: Envelope.new(duration: duration,
                                                                  attack:   0.15,
                                                                  sustain:  0.2,
                                                                  decay:    0.6),
                                           output_file_name: 'delete_me')
  end

  def test_hear_results
    puts @envelope_note
    @envelope_note.play
  end
end
