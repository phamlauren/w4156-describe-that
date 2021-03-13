class ModifyFieldsOfAllModels < ActiveRecord::Migration[6.1]
  def change
    # user - field null status
    change_column_null :users, :email, false
    change_column_null :users, :password, false
    change_column_null :users, :options, false

    # user - option field type and default
    change_column :users, :options, :jsonb
    change_column_default :users, :options, from: nil, to: { :default_lang => "en" }

    # video - field null status
    change_column_null :videos, :yt_video_id, false
    change_column_null :videos, :deleted, false

    # video - deleted field default
    change_column_default :videos, :deleted, false

    # description track - field null status
    change_column_null :description_tracks, :video_id, false
    change_column_null :description_tracks, :track_author_id, false
    change_column_null :description_tracks, :lang, false
    change_column_null :description_tracks, :is_generated, false

    # description track - lang field default
    change_column_default :description_tracks, :lang, "en"

    # description - field null status
    change_column_null :descriptions, :desc_track_id, false
    change_column_null :descriptions, :start_time_sec, false
    change_column_null :descriptions, :pause_at_start_time, false

    # recorded description - field null status
    change_column_null :recorded_descriptions, :audio_file_loc, false
    change_column_null :recorded_descriptions, :description_text, true

    # generated description - field null status
    change_column_null :generated_descriptions, :audio_file_loc, false
    change_column_null :generated_descriptions, :description_text, false
    change_column_null :generated_descriptions, :tts_voice_id, false
    change_column_null :generated_descriptions, :tts_speed, false

    # generated description - speed field default
    change_column_default :generated_descriptions, :tts_speed, 1.0

    # voice - field null status
    change_column_null :voices, :common_name, false
    change_column_null :voices, :system_name, false
    change_column_null :voices, :provider, false
  end
end
