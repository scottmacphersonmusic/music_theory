# coding: utf-8
require 'music_theory/output'

module MusicTheory
  class Note
    include MusicTheory::Output
    attr_accessor :frequency,  :duration, :output_file_name, :envelope, :distort

    def initialize(options = {})
      @frequency        = options[:frequency] || 440.0          # Note frequency in Hz
      @frequency        = @frequency.to_f
      @duration         = options[:duration] ||  1.0            # Number of seconds per note
      @envelope         = options[:envelope] || false
      @distort          = options[:distort] || false
      @output_file_name = options[:output_file_name] || 'note'  # File name to write (without extension)
    end

    def total_frames
      # We want 1 second of the note, so we need 1 second's worth of frames
      (duration * sample_rate).to_i
    end

    def cycles_per_frame
      # each frame, we want this fraction of a cycle:
      frequency / sample_rate
    end

    def sine_wave_cycle
      # A cycle is a full sine wave, which is 2π radians:
      2 * Math::PI * cycles_per_frame
    end

    def samples
      # So to create a note that's one second long, we need to write out all the samples in the sine waves
      phase = 0
      samples = total_frames.times.map do
        sample = (Math.sin phase).to_f
        phase += sine_wave_cycle
        sample
      end
      samples = envelope!(samples) if envelope
      samples = distort!(samples) if distort
      samples
    end

    def envelope!(samples)
      # some function that filters amplitude over the duration of a given note - (to be expanded on)
      # attack should go from 0 amplitude to max over the course of the first 1/4 of note duration
      # sustain for the second quarter of the note duration
      # decay should take the rest of the duration (3/4 and 4/4) of the note to return to 0
      max_amplitude = samples.map {|s| s.abs }.max
      slice_size = samples.length / 4
      attack_slice = samples[0..slice_size]
      sustain_slice = samples[slice_size..(slice_size * 2)]
      decay_slice = samples[(slice_size * 2)..(slice_size * 4)]

      amplitude = 0
      attack_incrementor = max_amplitude / slice_size
      attack = attack_slice.each do |sample|
        sample = amplitude
        amplitude += attack_incrementor
      end

      sustain = sustain_slice.map {|sample| sample = max_amplitude}

      amplitude = max_amplitude
      decay_incrementor = max_amplitude / (slice_size * 2)
      decay = decay_slice.each do |sample|
        sample = amplitude
        amplitude -= decay_incrementor
      end

      samples = [attack, sustain, decay].flatten
    end

    def distort!(samples)
      samples.map do |sample|
        negative = sample < 0
        sample *= 8.to_f
        if sample.abs > 5
          sample = 5
          sample *= -1 if negative
        end
        sample /= 8.to_f
      end
    end
  end
end
