require 'music_theory/output'

module MusicTheory
  class Harmonize
    include MusicTheory::Output

    def initialize(*things_to_flatten)
      @things_to_flatten = things_to_flatten
    end

    def samples
      return @samples if @samples

      max_sample_array_length = @things_to_flatten.map(&:length).max
      @samples = Array.new(max_sample_array_length, 0)

      @things_to_flatten.each do |group|
        group.each_with_index do |value, i|
          @samples[i] +=  value
        end
      end

      max = @samples.map {|s| s.abs }.max
      multiplier = 1.0 / max
      @samples.map!{ |s| multiplier * s }
    end
  end
end
