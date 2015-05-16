require 'test_helper'

class TestNote < MiniTest::Test
  def setup
    @note_1 = MusicTheory::Note.new(frequency: 220, duration: 2.0)
  end

  def test_total_frames
    sample_rate = 22050
    frames = (2.0 * sample_rate).to_i
    assert_equal frames, @note_1.total_frames
  end
end
