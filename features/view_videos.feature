Feature: view videos

  As a person with visual impairments
  So that I can understand a video with more context than its sound
  I want to find videos with audio descriptions

Background: existing YouTube videos

    Given the following users exist:
    | id | email                    | password          | options                |
    | 1  | vishnu.nair@columbia.edu | password          | {"default_lang": "en"} |
    | 2  | xw2765@columbia.edu      | drowssap          | {"default_lang": "en"} |
    | 3  | lyp2106@barnard.edu      | thisIsMyPassword! | {"default_lang": "en"} |

    Given the following YouTube videos exist:
    | id | yt_video_id |
    | 1  | 1           |
    | 2  | 2           |
    | 3  | 3           |
    | 4  | 4           |

    Given the following description tracks exist:
    | id | video_id | track_author_id | lang | is_generated |
    | 1  | 1        | 1               | en   | true         |
    | 2  | 2        | 2               | en   | true         |
    | 3  | 3        | 3               | en   | true         |

    Given the following descriptions exist:
    | desc_track_id | start_time_sec | pause_at_start_time | audio_file_loc | desc_text              | voice_id | voice_speed | desc_type |
    | 1             | 1              | true                | loc1           | This is AD for video 1 | 1        | 1           | generated |
    | 2             | 2              | false               | loc2           | This is AD for video 2 | 2        | 2           | generated |
    | 3             | 3              | true                | loc3           | This is AD for video 3 | 3        | 3           | generated |


# Checks that we can find the video through the YouTube API
# Scenario: find the video I want
#   When I go to the home page
#   And I fill in "YouTube link" with ""
#   Then I should be on the "" page
#   And I should see ""

# Add step for getting the video from the YouTube API
# Replace "yt_vide_id: \"1\"" with YouTube link
Scenario: find a video with AD (happy path)
  When I am on the view page for the YouTube link "1"
  Then I should see "This is AD for video 1"
  
# Add step for geting the video from the YouTube API
# Replace "yt_vide_id: \"1\"" with YouTube link
Scenario: find a video without AD (sad) which I can then request (happy)
  When I am on the view page for the YouTube link "4"
  Then I should see "This video does not yet have audio descriptions"
  And I press "Request AD for this video"
  Then I should see "You have successfully requested AD for this video"

Scenario: upvote / downvote a video request

