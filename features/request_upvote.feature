Feature: view videos

  As a person with visual impairments
  So that I can understand a video with more context than its sound
  I want to find videos with audio descriptions

Background: existing YouTube videos

    Given the following users exist:
    | id | username    | auth0_id | options                |
    | 1  | vishnu.nair | asdffdsa | {"default_lang": "en"} |
    | 2  | xw2765      | fdsaasdf | {"default_lang": "en"} |
    | 3  | lyp2106     | jkl;;lkj | {"default_lang": "en"} |

    Given the following YouTube videos exist:
    | id | yt_video_id |
    | 1  | 1           |
    | 2  | 2           |
    | 3  | 3           |
    | 4  | 4           |

    Given the following video requests exist:
    | id | video_id | requested_lang | requester_id |
    | 1  | 1        | en             | 1            |

    And I am on the home page

Scenario: find a video without AD (sad) which I can then request (happy)
  When I am on the view page for the video id "4"
  Then I should see "This video does not yet have audio descriptions"
  And I press "Request AD for this video"
  Then I should see "Your request has been saved!"

Scenario: upvote / downvote a video request from the request page
  When I am on the Video Requests page
  And I click "Upvote this request" for the video request id "1"
  And I should be on the Video Requests page

