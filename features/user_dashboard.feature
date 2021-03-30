Feature: see list of users

  As a user
  So that I can see my requests, upvotes, and descriptions
  I want to see my dashboard

Background: users in database

    Given the following users exist:
    | id | username    | auth0_id | options                |
    | 1  | vishnu.nair | asdffdsa | {"default_lang": "en"} |
    | 2  | xw2765      | fdsaasdf | {"default_lang": "en"} |
    | 3  | lyp2106     | jkl;;lkj | {"default_lang": "en"} |

Scenario: see dashboard
  Given I am on the home page
  And I go to my dashboard
  Then I should see "xw2765"
