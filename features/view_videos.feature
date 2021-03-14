Feature: view videos

  As a person with visual impairments
  So that I can understand a video with more context than its sound
  I want to find videos with audio descriptions

Background: existing YouTube videos

    Given the following YouTube videos exist:

Scenario: search and find the video I want
  When I go to the home page
  And I fill in "search by title" with ""
  Then I should be on the results page
  And I should see ""

Scenario: access audio descriptions for the video I found (happy path)
  When I am on the page for ""
  And I click on "Text description"
  Then I should see ""

Scenario: request audio descriptions for the video I found (happy path)
  When I am on the page for ""
  And I click on "Request audio descriptions for this video"
  Then I should see ""

Scenario: upvote / downvote a video

Scenario: upvote / downvote a video request

