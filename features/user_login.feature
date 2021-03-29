Feature: see list of users

  As a TA
  So that I can grade this project
  I want to see the list of users

Background: users in database

    Given the following users exist:
    | id | username    | auth0_id | options                |
    | 1  | vishnu.nair | asdffdsa | {"default_lang": "en"} |
    | 2  | xw2765      | fdsaasdf | {"default_lang": "en"} |
    | 3  | lyp2106     | jkl;;lkj | {"default_lang": "en"} |

Scenario: see list of users
  And I am on the home page
  And I go to the Users index page
  Then I should see "vishnu.nair"

# NOTICE: THIS FEATURE IS NOW OBSOLETE.
# Describe-That uses Auth0 for authentication

# Feature: log in as a user

#   As a random Internet surfer
#   So that I can add audio descriptions for my friends
#   I want to log into describe-that

# Background: users in databse

#   Given the following users exist:
#   | email                    | password          | options                |
#   | vishnu.nair@columbia.edu | password          | {"default_lang": "en"} |
#   | xw2765@columbia.edu      | drowssap          | {"default_lang": "en"} |
#   | lyp2106@barnard.edu      | thisIsMyPassword! | {"default_lang": "en"} |

# Scenario: create myself as a user
#   When I go to the new user page
#   And I fill in the "email" field with "lauren.pham@columbia.edu"
#   And I fill in the "password" field with "thisIsMyPassword!"
#   And I press "Create"
#   Then I should be on the Users index page
#   And I should see "lyp2106@barnard.edu"

# Scenario: log in (happy path)
#   When I go to the user login page
#   And I fill in the "email" field with "lyp2106@barnard.edu"
#   And I fill in the "password" field with "thisIsMyPassword!"
#   And I press "Log in"
#   Then I should see "lyp2106@barnard.edu"

# Scenario: log in (sad path: incorrect password)
#   When I go to the user login page
#   And I fill in the "email" field with "lyp2106@barnard.edu"
#   And I fill in the "password" field with "thisIsNotMyPassword!"
#   And I press "Log in"
#   Then I should see "You have entered an incorrect password for this email"

# Scenario: log in (sad path: user does not exist)
#   When I go to the user login page
#   And I fill in the "email" field with "lyp2106@columbia.edu"
#   And I fill in the "password" field with "thisIsMyPassword!"
#   And I press "Log in"
#   Then I should see "A user does not yet exist for this email"

# Scenario: edit user login info