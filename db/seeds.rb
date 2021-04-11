# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'

# All voices.

# US voices.
voice_us_a = Voice.create!(common_name: "Voice US A", system_name: "en-US-Wavenet-A", provider: "google_tts")
voice_us_b = Voice.create!(common_name: "Voice US B", system_name: "en-US-Wavenet-B", provider: "google_tts")
voice_us_c = Voice.create!(common_name: "Voice US C", system_name: "en-US-Wavenet-C", provider: "google_tts")
voice_us_d = Voice.create!(common_name: "Voice US D", system_name: "en-US-Wavenet-D", provider: "google_tts")
voice_us_e = Voice.create!(common_name: "Voice US E", system_name: "en-US-Wavenet-E", provider: "google_tts")
voice_us_f = Voice.create!(common_name: "Voice US F", system_name: "en-US-Wavenet-F", provider: "google_tts")
voice_us_g = Voice.create!(common_name: "Voice US G", system_name: "en-US-Wavenet-G", provider: "google_tts")
voice_us_h = Voice.create!(common_name: "Voice US H", system_name: "en-US-Wavenet-H", provider: "google_tts")
voice_us_i = Voice.create!(common_name: "Voice US I", system_name: "en-US-Wavenet-I", provider: "google_tts")
voice_us_j = Voice.create!(common_name: "Voice US J", system_name: "en-US-Wavenet-J", provider: "google_tts")

# GB voices.
voice_gb_a = Voice.create!(common_name: "Voice GB A", system_name: "en-GB-Wavenet-A", provider: "google_tts")
voice_gb_b = Voice.create!(common_name: "Voice GB B", system_name: "en-GB-Wavenet-B", provider: "google_tts")
voice_gb_c = Voice.create!(common_name: "Voice GB C", system_name: "en-GB-Wavenet-C", provider: "google_tts")
voice_gb_d = Voice.create!(common_name: "Voice GB D", system_name: "en-GB-Wavenet-D", provider: "google_tts")
voice_gb_e = Voice.create!(common_name: "Voice GB E", system_name: "en-GB-Wavenet-E", provider: "google_tts")
voice_gb_f = Voice.create!(common_name: "Voice GB F", system_name: "en-GB-Wavenet-F", provider: "google_tts")

# FR voices.
voice_fr_a = Voice.create!(common_name: "Voice FR A", system_name: "fr-FR-Wavenet-A", provider: "google_tts")
voice_fr_b = Voice.create!(common_name: "Voice FR B", system_name: "fr-FR-Wavenet-B", provider: "google_tts")
voice_fr_c = Voice.create!(common_name: "Voice FR C", system_name: "fr-FR-Wavenet-C", provider: "google_tts")
voice_fr_d = Voice.create!(common_name: "Voice FR D", system_name: "fr-FR-Wavenet-D", provider: "google_tts")
voice_fr_e = Voice.create!(common_name: "Voice FR E", system_name: "fr-FR-Wavenet-E", provider: "google_tts")

# YouTube videos
v1 = Video.create!(yt_video_id: "S1x76DoACB8") # "Frozen" teaser trailer
v2 = Video.create!(yt_video_id: "Jn09UdSb3aA") # The Best of Chopin

# User
user1 = User.create!(username: "test.user.1", auth0_id: "abcde")
user2 = User.create!(username: "test.user.2", auth0_id: "edcba")

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

    Description.create!(
      desc_track_id: dt.id,
      start_time_sec: desc["start_time_sec"],
      pause_at_start_time: desc["pause_at_start_time"],
      desc_type: desc["desc_type"],
      audio_file_loc: target_file_name,
      desc_text: desc["desc_text"],
      voice_id: desc["voice_id"],
      voice_speed: desc["voice_speed"]
    )
  end
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