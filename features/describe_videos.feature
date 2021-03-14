Feature: describe videos

  As a volunteer
  So that I can provide audio descriptions for my friends
  First of all I want to find videos via a valid YouTube URL
  Then I want to add AD to them

Background: existing YouTube videos

    Given I can access the following YouTube videos:
        | Title       | yt_video_id |
        | Transitions | 40z9n1SgozU |
 
Scenario: enter a valid URL to describe

    When I am on the home page

    And I fill in "yt_url" with "https://www.youtube.com/watch?v=40z9n1SgozU"

    And I press "Describe"

    Then I am on the describe page for "Transitions"

Scenario: enter a valid URL generated by Share to describe

    When I am on the home page

    And I fill in "yt_url" with "youtu.be/40z9n1SgozU?t=57"

    And I press "Describe"

    Then I am on the describe page for "Transitions"

Scenario: enter an invalid URL to share

    When I am on the home page

    And I fill in "yt_url" with "https://www.youtube.com/watch?v=40z9n"

    And I press "Describe"

    Then I should see "Invalid YouTube URL"

Scenario: go back to home page if no URL in params

    When I am on the new description_track page

    Then I am on the home page

Scenario: add one description for the video I found
    
    When I am on the new description_track page for "Transitions"

    And I fill in "time" with "0:01"

    And I fill in "description" with "people walking around"

    And I press "Add One Description"

    Then I should see "people walking around at 0:01"

    Then I press "Submit"

    Then I am on the description_track page

    And I should see "Transitions"

    And I should see "people walking around at 0:01"