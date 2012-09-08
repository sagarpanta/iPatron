Feature: navigate through events, promotions, offers,  notifications and news
  As a player
  So that I can navigate through tabs
  I want to see my either offers or promotions or events, or account details
  
  
Scenario: player navigates to offers and sees offers
  Given the player "101" is logged in
  Given he is in player home page
  Given he has some offers
  When he clicks on the offer tab
  Then he should see the offers ordered by created date
  
  
