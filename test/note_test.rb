require 'test_helper'

class TestNote < MiniTest::Test
  def setup
    @frequency   = 220.to_f
    @duration    = 2.0
    @sample_rate = 22050
    @total_frames = (@duration * @sample_rate).to_i
    @cycles_per_frame = @frequency / @sample_rate
    @sine_wave_cycle = 2 * Math::PI * @cycles_per_frame
    @note = MusicTheory::Note.new(frequency: @frequency, duration: @duration)
  end

  def test_total_frames
    assert_equal @total_frames, @note.total_frames
  end

  def test_cycles_per_frame
    assert_equal @cycles_per_frame, @note.cycles_per_frame
  end

  def test_sine_wave_cycle
    assert_equal @sine_wave_cycle, @note.sine_wave_cycle
  end

  def test_samples
    phase = 0
    samples = @total_frames.times.map do
      sample = (Math.sin phase).to_f
      phase += @sine_wave_cycle
      sample
    end
    assert_equal samples, @note.samples
  end
end
