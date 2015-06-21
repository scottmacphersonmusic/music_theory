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

    @e = @envelope_note.envelope
  end

  def test_envelope_frames_matches_total_frames
    assert_equal @e.total_frames, @e.envelope_frames.length
  end

  def test_peak_amplitude_arrival
    peak_amplitude_index = @e.attack_frames.length
    assert @e.envelope_frames[peak_amplitude_index - 1] < 1
    assert_equal 1, @e.envelope_frames[peak_amplitude_index]
  end

  def test_sustain_ending
    sustain_ending_index = @e.attack_frames.length \
                           + @e.sustain_frames.length - 1
    assert_equal 1, @e.envelope_frames[sustain_ending_index]
    assert @e.envelope_frames[sustain_ending_index + 1] < 1
  end

  def test_decay_ending
    decay_ending_index = @e.attack_frames.length \
                         + @e.sustain_frames.length \
                         + @e.decay_frames.length - 1
    assert @e.envelope_frames[decay_ending_index - 1] > 0
    assert_equal 0, @e.envelope_frames[decay_ending_index]
  end
end
