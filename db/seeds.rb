# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# All voices.

# US voices.
Voice.create(common_name: "Voice US A", system_name: "en-US-Wavenet-A", provider: "google_tts")
Voice.create(common_name: "Voice US B", system_name: "en-US-Wavenet-B", provider: "google_tts")
Voice.create(common_name: "Voice US C", system_name: "en-US-Wavenet-C", provider: "google_tts")
Voice.create(common_name: "Voice US D", system_name: "en-US-Wavenet-D", provider: "google_tts")
Voice.create(common_name: "Voice US E", system_name: "en-US-Wavenet-E", provider: "google_tts")
Voice.create(common_name: "Voice US F", system_name: "en-US-Wavenet-F", provider: "google_tts")
Voice.create(common_name: "Voice US G", system_name: "en-US-Wavenet-G", provider: "google_tts")
Voice.create(common_name: "Voice US H", system_name: "en-US-Wavenet-H", provider: "google_tts")
Voice.create(common_name: "Voice US I", system_name: "en-US-Wavenet-I", provider: "google_tts")
Voice.create(common_name: "Voice US J", system_name: "en-US-Wavenet-J", provider: "google_tts")

# GB voices.
Voice.create(common_name: "Voice GB A", system_name: "en-GB-Wavenet-A", provider: "google_tts")
Voice.create(common_name: "Voice GB B", system_name: "en-GB-Wavenet-B", provider: "google_tts")
Voice.create(common_name: "Voice GB C", system_name: "en-GB-Wavenet-C", provider: "google_tts")
Voice.create(common_name: "Voice GB D", system_name: "en-GB-Wavenet-D", provider: "google_tts")
Voice.create(common_name: "Voice GB E", system_name: "en-GB-Wavenet-E", provider: "google_tts")
voice = Voice.create(common_name: "Voice GB F", system_name: "en-GB-Wavenet-F", provider: "google_tts")

# YouTube videos
v1 = Video.create(yt_video_id: "Rk1MYMPDx3s")
v2 = Video.create(yt_video_id: "Jn09UdSb3aA")
v3 = Video.create(yt_video_id: "Ct6BUPvE2sM")
v4 = Video.create(yt_video_id: "l1heD4T8Yco")
v5 = Video.create(yt_video_id: "E-6xk4W6N20")

# User
vishnu = User.create(username: "vishnu.nair", auth0_id: "abcde")
sheron = User.create(username: "xw2765", auth0_id: "edcba")
lauren = User.create(username: "lyp2106", auth0_id: "zyxw")

# Description Track
d1 = DescriptionTrack.create(video_id: v1.id, track_author_id: vishnu.id, is_generated: true, published: true)
d2 = DescriptionTrack.create(video_id: v2.id, track_author_id: sheron.id, is_generated: true, published: true)
d3 = DescriptionTrack.create(video_id: v3.id, track_author_id: lauren.id, is_generated: true, published: true)
d4 = DescriptionTrack.create(video_id: v4.id, track_author_id: vishnu.id, is_generated: true, published: true)
d5 = DescriptionTrack.create(video_id: v5.id, track_author_id: sheron.id, is_generated: true, published: true)

# Description
d1_1 = Description.create(desc_track_id: d1.id, start_time_sec: 1, pause_at_start_time: false, desc_type: 'generated', audio_file_loc: "", desc_text: "(desc 1) walking around", voice_id: voice.id, voice_speed: 1.1)
d1_2 = Description.create(desc_track_id: d1.id, start_time_sec: 12, pause_at_start_time: false, desc_type: 'generated', audio_file_loc: "", desc_text: "(desc 2) say hello", voice_id: voice.id, voice_speed: 1.1)
d2_1 = Description.create(desc_track_id: d2.id, start_time_sec: 23, pause_at_start_time: false, desc_type: 'generated', audio_file_loc: "", desc_text: "is Waltz No. 8 in A-Flat Major, Op. 64, No.3 or fight me", voice_id: voice.id, voice_speed: 1.1)
d3_1 = Description.create(desc_track_id: d3.id, start_time_sec: 13, pause_at_start_time: false, desc_type: 'generated', audio_file_loc: "", desc_text: "say it five times fast pen pineapple apple pen pen pineapple apple pen", voice_id: voice.id, voice_speed: 1.1)
d4_1 = Description.create(desc_track_id: d4.id, start_time_sec: 123, pause_at_start_time: false, desc_type: 'generated', audio_file_loc: "", desc_text: "hamtaro is that u uwu", voice_id: voice.id, voice_speed: 1.1)
d5_1 = Description.create(desc_track_id: d5.id, start_time_sec: 13, pause_at_start_time: false, desc_type: 'generated', audio_file_loc: "", desc_text: "#90sKidsRemember og Disney", voice_id: voice.id, voice_speed: 1.1)

# Video requests
r1 = VideoRequest.create(video_id: v1.id, requested_lang: 'en', requester_id: lauren.id)