Feature: see list of users

  As a TA
  So that I can grade this project
  I want to see the list of users and videos

Background: users in database

    Given the following users exist:
    | id | username    | auth0_id | options                |
    | 1  | vishnu.nair | asdffdsa | {"default_lang": "en"} |
    | 2  | xw2765      | fdsaasdf | {"default_lang": "en"} |
    | 3  | lyp2106     | jkl;;lkj | {"default_lang": "en"} |

    Given the following YouTube videos exist:
    | id | yt_video_id |
    | 1  | Rk1MYMPDx3s |
    | 2  | Jn09UdSb3aA |
    | 3  | Ct6BUPvE2sM |
    | 4  | l1heD4T8Yco |

Scenario: see list of users
  And I am on the home page
  And I go to the Users index page
  Then I should see "vishnu.nair"

Scenario: see list of undescribed videos
  And I am on the home page
  And I go to the video index page
  Then I should see "The Best of Chopin"


