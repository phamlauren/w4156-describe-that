Feature: describe videos

  As a volunteer
  So that I can provide audio descriptions for my friends
  First of all I want to find videos via a valid YouTube URL
  Then I want to add generated ADs to them
  Then I want to add recorded ADs to them
  Lastly I want to set it published or unpublished anytime I want

Background: existing user

    Given the following users exist:
    | id | username    | auth0_id | options                |
    | 99 | xw2765      | fdsaasdf | {"default_lang": "en"} |

    Given the following voices exist:
    | id| common_name                        | system_name     | provider   | language_code | country_code | gender | natural_sample_rate_hz
    | 1 | en-US-Wavenet-A (male, Google TTS) | en-US-Wavenet-A | google_tts | en            | US           | male   | 24000
    | 2 | en-US-Wavenet-B (male, Google TTS) | en-US-Wavenet-B | google_tts | en            | US           | male   | 24000


    And I am on the home page

    And I fill in "yt_url" with "https://www.youtube.com/watch?v=40z9n1SgozU"

    And I press "Go"

    Then I should be on the show page for "40z9n1SgozU"

@javascript
Scenario: publish and unpublish description track

    And I should see "Transitions"

    And I should see "This video does not yet have audio descriptions."

    And I press "Describe this video"

    And I should see "Describe: Transitions"

    And I press "Publish Description Track"

    Then I go back

    Then "Save Description Track" should be enabled

    And "Unpublish Description Track" should be enabled

    And I press "Unpublish Description Track"

    Then "Unpublish Description Track" should be disabled

    And I press "Save Description Track"

    Then I go back

    And "Unpublish Description Track" should be enabled


@javascript
Scenario: add and edit generated descriptions for the video I found

    When I press "Describe this video"

    And I press "Add one new generated description at current time!"

    Then I should see "Start time (sec):"

    And I should see "Voice speed:"
    
    And I fill in "Description text" with "people walking around"

    And I fill in "time" with "3.1"

    And I fill in "voice_speed" with "1.5"

    And I select "extended" from "pause_at_start_time"

    And I select "en-US-Wavenet-A (male, Google TTS)" from "voice_id"

    And I press "Add"

    Then I should see "3.1"

    Then I should see "extended"

    Then I press "edit"

    Then the "description" field should contain "people walking around"

    Then I fill in "time" with "2.5"

    Then I fill in "description" with "people not walking around"

    Then I press "Add"

    Then I should see "2.5"

    Then I press "edit"

    Then the "description" field should contain "people not walking around"

    Then I press "Remove"

    Then I should not see "people not walking around"

    And I press "Add one new generated description at current time!"

    And I fill in "description" with "using default values"

    Then I press "Add"

    Then I should see "0.0"

    Then I should see "inline"

@javascript
Scenario: add one recorded description form

    And I press "Describe this video"

    And I press "Add one new recorded description at current time!"

    Then the "time" field should contain "0.0"

    Then I should see "Get Rec Permission"
    
    And I should see "Add"

    Then "Add" should be disabled

@javascript
Scenario: no TTS button when no corresponding language is available

    Given the following description tracks exist:
    |video_id | track_author_id | published | lang |
    | 1       | 99              | true      | en   |

    Given I am on the show page for "40z9n1SgozU"

    And I select "Urdu" from "lang"

    And I press "Create new track!"

    Then "No TTS voices available for Urdu." should be disabled
