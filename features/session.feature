Feature: login in player with username and password
  As a player
  So that I can login to the application
  I want to see my account details page
  
  
Scenario: player is greeted upon successful logon
  Given the player "101" has an account
  When he logs in
  Then he should see "Welcome John Doe"
  
  
