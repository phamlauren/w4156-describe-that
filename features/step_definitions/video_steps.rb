Given /the following YouTube videos exist/ do |videos_table|
    videos_table.hashes.each do |video|
      Video.create! video
    end
end

Given /the following description tracks exist/ do |description_tracks_table|
    description_tracks_table.hashes.each do |description_track|
      DescriptionTrack.create! description_track
    end
end

Given /the following descriptions exist/ do |descriptions_table|
    descriptions_table.hashes.each do |description|
      Description.create! description
    end
end

Given /the following video requests exist/ do |requests_table|
  requests_table.hashes.each do |request|
    VideoRequest.create! request
  end
end

Given /I click "Upvote this request" for the video request id "(.*)"/ do |video_id|
  step "I am on the upvote request page for the video request id \"#{video_id}\""
end