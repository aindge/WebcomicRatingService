Feature: Allow a user to rate comics
    As a user 
    I want to be able to rate comics
    So I can I can tell people of good comics and warn others of bad ones

Background: comics have been added to database

  Given the following comics exist:
  | name                | author       | url                |
  | Cheddar             | Nacho Comics | www.something.com  |
  | YourFavoriteDies    | Bad Man      | www.something.com  |
  | GenericComic        | Someone      | www.something.com  |
 #spaces removed because Cucumber is picky. The code works fine for spaces

  And the following users exist:
  | username	| password	|  email			|
  | JohnEgbert 	| JohnEgbert  	| ectoBiologist@bluh.com    	|
  | RoseLalonde	| RoseLalonde  	| tentacleTherapist@bluh.com   	| 
  | DaveStrider	| DaveStrider	| turntechGod@bluh.com    	|

  And I am on the home page
  And I am logged in as "JohnEgbert"

Scenario: rate a comic initially
	When I click "Rate" for comic "Cheddar"
	When I rate "Cheddar"'s "comic overall" field with "5"
	Then I should be on the homepage
	And I should see /Cheddar.*5/

Scenario: rate a comic again
	When I click "Rate" for comic "YourFavoriteDies"
	When I rate "YourFavoriteDies"'s "art" field with "5"
	Then I should be on the homepage
	And I should see /YourFavoriteDies.*5/
	Then I switch to user "RoseLalonde"
	When I rate "YourFavoriteDies"'s "art" field with "3"
	Then I should see /YourFavoriteDies.*4/
	Then I switch to user "DaveStrider"
	When I rate "YourFavoriteDies"'s "art" field with "1"
	Then I should see /YourFavoriteDies.*3/

Scenario: rate a comic so the averate is a decimal
	When I rate "GenericComic"'s "story" field with "5"
	And I click "Show" for comic "GenericComic"
	Then I should see "Rating Story: 5"
	And I click "Back"
	Then I switch to user "RoseLalonde"
	When I rate "GenericComic"'s "story" field with "2"
	And I click "Show" for comic "GenericComic"
	Then I should see "Rating Story: 3.5"
	And I click "Back"
	Then I switch to user "DaveStrider"
	When I rate "GenericComic"'s "story" field with "1"
	And I click "Show" for comic "GenericComic"
	Then I should see "Rating Story: 2.6"
