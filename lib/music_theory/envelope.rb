class Envelope
  attr_accessor :duration, :attack, :sustain, :decay, :sample_rate, :total_frames

  def initialize(options = {})
    @duration = options[:duration]
    @attack   = options[:attack]    # in seconds   ex: 0.15
    @sustain  = options[:sustain]   # percentage   ex: 30
    @decay    = options[:decay]     # percentage   ex: 60
    @sample_rate = 22050
    @total_frames = @sample_rate * @duration
  end

  def attack_frames
    attack_frames_count = (@sample_rate * @attack).to_i
    growth_rate = (1.0 / attack_frames_count.to_f)
    attack_frames = Array.new(attack_frames_count){ |index| index * growth_rate }
    attack_frames
  end

  def sustain_frames
    sustain_frames_count = (@total_frames - attack_frames.length) * (@sustain.to_f / 100.0)
    sustain_frames = Array.new(sustain_frames_count) { 1 }
    sustain_frames
  end

  def decay_frames
    decay_frames_count = (@total_frames - attack_frames.length) * (@decay.to_f / 100.0)
    decay_rate = (1.0 / decay_frames_count)
    decay_frames = Array.new(decay_frames_count){ |index| index * decay_rate }.reverse
    decay_frames
  end

  def envelope_frames
    envelope_frames = attack_frames + sustain_frames + decay_frames
    if envelope_frames.length < @total_frames
      remainder = @total_frames - envelope_frames.length
      filler = Array.new(remainder){ 0 }
      envelope_frames += filler
    end
    envelope_frames
  end
end
