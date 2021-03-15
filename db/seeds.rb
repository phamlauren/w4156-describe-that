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
Voice.create(common_name: "Voice GB F", system_name: "en-GB-Wavenet-F", provider: "google_tts")