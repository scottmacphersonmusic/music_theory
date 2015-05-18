require 'test_helper'

class TestNote < MiniTest::Test
  def setup
    @frequency   = 220.to_f
    @duration    = 2.0
    @sample_rate = 22050
    @cycles_per_frame = @frequency / @sample_rate
    @note = MusicTheory::Note.new(frequency: @frequency, duration: @duration)
  end

  def test_total_frames
    frames = (@duration * @sample_rate).to_i
    assert_equal frames, @note.total_frames
  end

  def test_cycles_per_frame
    assert_equal @cycles_per_frame, @note.cycles_per_frame
  end

  def test_sine_wave_cycle
    sine_wave_cycle = 2 * Math::PI * @cycles_per_frame
    assert_equal sine_wave_cycle, @note.sine_wave_cycle
  end
end
