require 'streamio-ffmpeg'
require 'securerandom'

module AudioHelper
  def self.trim_silence(input_io)
    # FFmpeg command to execute:
    #   ffmpeg -i out_sil.wav
    #   -af silenceremove=start_periods=1:start_silence=0.1:start_threshold=-80dB,areverse,silenceremove=start_periods=1:start_silence=0.1:start_threshold=-80dB,areverse
    #   out2.wav
    #
    # Some sample read/write instructions:
    #   in_contents = File.open("out_sil.wav", 'rb') { |f| f.read }
    #   inio = StringIO.new(in_contents)
    #   outio = AudioHelper.trim_silence(inio)
    #   File.open("out_sil_TEST.wav", 'wb') { |f| f.puts(outio.read) }

    # generate tmp filenames
    this_uuid = SecureRandom.uuid
    input_filename = "tmp/#{this_uuid}_tmp.wav"
    out_filename = "tmp/#{this_uuid}_tmp_OUT.wav"

    # write input StringIO to a temp file
    File.open(input_filename, 'wb') do |f|
      f.puts(input_io.read)
    end

    # run it through FFmpeg to remove silence on both ends and write output to tmp folder
    audio_file = FFMPEG::Movie.new(input_filename)
    audio_file.transcode(out_filename, %w(-af silenceremove=start_periods=1:start_silence=0.1:start_threshold=-80dB,areverse,silenceremove=start_periods=1:start_silence=0.1:start_threshold=-80dB,areverse))

    # read in that output file, delete the temp files, and return output as a new StringIO
    stripped_contents = File.open(out_filename, 'rb') { |f| f.read }

    File.delete(input_filename) if File.exists?(input_filename)
    File.delete(out_filename) if File.exists?(out_filename)

    StringIO.new(stripped_contents)
  end
end
