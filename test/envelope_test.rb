require 'test_helper'

class TestEnvelope < MiniTest::Test
  def setup
    @basic_note = MusicTheory::Note.new
  end

  def test_note_plays
    @basic_note.play
  end
end
