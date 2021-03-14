Given /the following YouTube videos exist/ do |videos_table|
    videos_table.hashes.each do |video|
      Video.create video
    end
end

Given /the following description tracks exist/ do |description_tracks_table|
    description_tracks_table.hashes.each do |description_track|
      DescriptionTrack.create description_track
    end
end

Given /the following generated descriptions exist/ do |generated_descriptions_table|
    generated_descriptions_table.hashes.each do |generated_description|
      GeneratedDescription.create generated_description
    end
end