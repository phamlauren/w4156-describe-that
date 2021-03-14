Feature: log in as a user

  As a random Internet surfer
  So that I can add audio descriptions for my friends
  I want to log into describe-that

Background:

Scenario: create myself as a user
  When I go to the new user page
  And I fill in the "email" field with "lyp2106@barnard.edu"
  And I fill in the "password" field with "thisIsMyPassword!"
  And I press "Create"
  Then I should be on the Users index page
  And I should see "lyp2106@barnard.edu"

Scenario: log in (happy path)
  When I go to the user login page
  And I fill in the "email" field with "lyk.pham@gmail.com"
  And I fill in the "password" field with "thisIsMyPassword!"
  And I press "Log in"
  Then I should see "lyk.pham@gmail.com"

Scenario: log in (sad path: incorrect password)
  When I go to the user login page
  And I fill in the "email" field with "lyk.pham@gmail.com"
  And I fill in the "password" field with "thisIsNotMyPassword!"
  And I press "Log in"
  Then I should see "You have entered an incorrect password for this email"

Scenario: log in (sad path: user does not exist)
  When I go to the user login page
  And I fill in the "email" field with "lyp2106@columbia.edu"
  And I fill in the "password" field with "thisIsMyPassword!"
  And I press "Log in"
  Then I should see "A user does not yet exist for this email"

Scenario: edit user login info