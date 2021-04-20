Feature: play videos

  As a user
  I want to play a description track
  And interact with others using this website
  First of all I want to find a video via a valid YouTube URL
  And I could favorite this video
  Then I want to play a description track of this video
  And I want to upvote this description track
  Lastly I want to add a comment to this description track


Background: existing user and description track

    Given the following users exist:
    | id | username    | auth0_id | options                |
    | 99 | xw2765      | fdsaasdf | {"default_lang": "en"} |

    Given the following voices exist:
    | id| common_name                        | system_name     | provider   | language_code | country_code | gender | natural_sample_rate_hz
    | 1 | en-US-Wavenet-A (male, Google TTS) | en-US-Wavenet-A | google_tts | en            | US           | male   | 24000
    | 2 | en-US-Wavenet-B (male, Google TTS) | en-US-Wavenet-B | google_tts | en            | US           | male   | 24000

    Given the following YouTube videos exist:
    | id | yt_video_id |
    | 1  | 40z9n1SgozU |

    Given the following description tracks exist:
    |video_id | track_author_id | published | lang |
    | 1       | 99              | true      | en   |

@javascript
Scenario: favorite this video

    Given I am on the home page

    And I fill in "yt_url" with "https://www.youtube.com/watch?v=40z9n1SgozU"

    And I press "Go"

    And I follow "Favorite"

    And I follow "Dashboard"

    Then I should see "Transitions"

@javascript
Scenario: upvote this description track

    Given I am on the home page

    And I fill in "yt_url" with "https://www.youtube.com/watch?v=40z9n1SgozU"

    And I press "Go"

    Then I follow "English descriptions by @xw2765"
    
    Then I follow "Vote on this track!"

    And I follow "See all tracks"

    Then I should see "1 votes"

    Then I follow "Dashboard"

    Then I should see "Transitions"

    And I should see "audio descriptions in English"

@javascript
Scenario: add a comment and a reply to this description track

    Given I am on the home page

    And I fill in "yt_url" with "https://www.youtube.com/watch?v=40z9n1SgozU"

    And I press "Go"

    Then I follow "English descriptions by @xw2765"

    Then I fill in "comment_text" with "good job"
    
    And I press "Post"
    
    Then I should see "good job"