require 'test_helper'

class TestEnvelope < MiniTest::Test
  def setup
    @long_note = MusicTheory::Note.new(duration: 4.0, envelope: true, output_file_name: 'delete_me')
  end

  def test_note_plays
    @long_note.play
  end
end
