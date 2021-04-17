# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'

# Get and store all voices and associated locales (Wavenet voices only)
target_url_voice_list = "https://texttospeech.googleapis.com/v1/voices?key=" + ENV["GOOGLE_TTS_API_KEY"]
resp = HTTParty.get(target_url_voice_list)

if resp.code != 200
  abort("Could not retrieve list of voices from Google Cloud TTS -- request returned code #{resp.code}")
end

# for each voice...
all_voices = resp["voices"]
all_voices.each do |v|
  system_name = v["name"]
  next unless system_name.include? "Wavenet" # only consider Wavenet voices

  target_locale_comps = v["languageCodes"][0].split('-')
  language_code = target_locale_comps[0]
  country_code = target_locale_comps[1]

  if ISO3166::Country.new(country_code).nil?
    country_code = nil
  end

  provider = "google_tts"
  gender = v["ssmlGender"].downcase
  natural_sample_rate_hz = v["naturalSampleRateHertz"]
  common_name = "#{system_name} (#{gender}, Google TTS)"

  Voice.create!(
    common_name: common_name,
    system_name: system_name,
    provider: provider,
    language_code: language_code,
    country_code: country_code,
    gender: gender,
    natural_sample_rate_hz: natural_sample_rate_hz
  )

  puts "Seeded voice: #{common_name}"
end

# YouTube videos
v1 = Video.create!(yt_video_id: "S1x76DoACB8", length_sec: 96) # "Frozen" teaser trailer
v2 = Video.create!(yt_video_id: "Jn09UdSb3aA", length_sec: 11526) # The Best of Chopin

# User
user1 = User.create!(username: "worlds-best-dad", auth0_id: "abcde")
user2 = User.create!(username: "better-than-worlds-best-dad", auth0_id: "edcba")

# Descriptions and tracks
# info blocks for pre-seeded descriptions
seed_desc_roots = [
  {
    :root => './db/seed_files/preseed1_frozen_eng',
    :target_prefix => 'ps1_',
    :author => user1,
    :video => v1,
    :lang => "en"
  },
  {
    :root => './db/seed_files/preseed2_frozen_fra',
    :target_prefix => 'ps2_',
    :author => user2,
    :video => v1,
    :lang => "fr"
  }
]

# for each block
seed_desc_roots.each do |info|
  root = info[:root]
  loc_prefix = info[:target_prefix]

  # create track
  dt = DescriptionTrack.create!(video_id: info[:video].id, track_author_id: info[:author].id, published: true, lang: info[:lang])
  info[:created_track] = dt

  d1_info_file = File.read(File.join(root, 'info.json'))
  d1_info_hash = JSON.parse(d1_info_file)

  d1_info_hash.each do |desc|
    target_file_name = loc_prefix + desc["audio_file_loc"]
    this_audio_file = File.read(File.join(root, desc["audio_file_loc"]))
    S3FileHelper.upload_file(target_file_name, this_audio_file)

    voice_system_name = desc["voice_system_name"]
    voice = Voice.where(system_name: voice_system_name).first

    Description.create!(
      desc_track_id: dt.id,
      start_time_sec: desc["start_time_sec"],
      pause_at_start_time: desc["pause_at_start_time"],
      desc_type: desc["desc_type"],
      audio_file_loc: target_file_name,
      desc_text: desc["desc_text"],
      voice_id: voice.id,
      voice_speed: desc["voice_speed"],
      video_volume_inline: desc["video_volume_inline"]
    )
  end

  puts "Seeded description track: #{info[:root]}"
end

# Description Track Comments
c1 = DescriptionTrackComment.create!(desc_track_id: seed_desc_roots[0][:created_track].id,
                                     comment_author_id: user1.id,
                                     comment_text: 'if you value your sanity, do not show your kids "Frozen" because they will become obsessed')
c2 = DescriptionTrackComment.create!(desc_track_id: seed_desc_roots[0][:created_track].id,
                                     comment_author_id: user2.id,
                                     comment_text: '^^ can confirm that this is true',
                                     parent_comment_id: c1.id)

# Video requests
r1 = VideoRequest.create!(video_id: v2.id, requested_lang: 'en', requester_id: user2.id)