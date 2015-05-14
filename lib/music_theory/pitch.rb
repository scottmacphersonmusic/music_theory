class Pitch
  attr_accessor :note, :octave

  def initialize(note, octave)
    @note   = prepare_note_for_offset_map(note)
    @octave = octave
  end

  # Formula to derive note frequencies of the equal tempered scale
  # http://www.phy.mtu.edu/~suits/NoteFreqCalcs.html
  def frequency
    growth_rate = 2 ** (1.0 / 12)
    frequency = 440 * (growth_rate ** semitones_from_A4)
    frequency.round(3)
  end

  def to_s
    note   = replace_sharp_or_flat(@note.to_s)
    octave = @octave.to_s
    return "#{note} #{octave}"
  end

  private

  NOTE_TO_SEMITONE_OFFSET_MAP = {B:   2,
                                 Bf:  1,
                                 As:  1,
                                 A:   0,
                                 Af: -1,
                                 Gs: -1,
                                 G:  -2,
                                 Gf: -3,
                                 Fs: -3,
                                 F:  -4,
                                 E:  -5,
                                 Ef: -6,
                                 Ds: -6,
                                 D:  -7,
                                 Df: -8,
                                 Cs: -8,
                                 C:  -9}

  def semitones_from_A4
    octave_diff = @octave - 4
    (octave_diff * 12) + NOTE_TO_SEMITONE_OFFSET_MAP[@note]
  end

  def replace_sharp_or_flat(note)
    if note[1] == "s"
      note[0] + "#"
    elsif note[1] == "f"
      note[0] + "b"
    else
      note
    end
  end

  def prepare_note_for_offset_map(note)
    letter = note[0].upcase
    accidental = if note[1] then
                   note[1].downcase
                 else
                   ""
                 end
    "#{letter}#{accidental}".to_sym
  end
end
