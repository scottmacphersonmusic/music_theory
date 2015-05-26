class Envelope
  attr_accessor :attack, :sustain, :decay

  def initialize(options = {})
    @attack  = options[:attack]
    @sustain = options[:sustain]
    @decay   = options[:decay]
  end


end
