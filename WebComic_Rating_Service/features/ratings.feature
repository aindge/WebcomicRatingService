Feature: Allow a user to rate comics
    As a user 
    I want to be able to rate comics
    So I can I can tell people of good comics and warn others of bad ones

Background: comics have been added to database

  Given the following comics exist:
  | name                | author       | url                |
  | Cheddar             | Nacho Comics | www.something.com  |
  | Your Favorite Dies  | Bad Man      | www.something.com  |
  | Genric Comic        | Someone      | www.something.com  |

  And I am on the home page

Scenario: rate a comic initially
	When I click "Rate Cheddar"
	When I rate "Cheddar"'s "comic overall" field with "5"
	Then I should be on the homepage
	And I should see /Cheddar.*5/

Scenario: rate a comic again
	When I click "Rate_Your Favorite Dies"
	When I rate "Your Favorite Dies"'s "art" field with "5"
	Then I should be on the homepage
	And I should see /Your Favorite Dies.*5/
	When I rate "Your Favorite Dies"'s "art" field with "3"
	Then I should see /Your Favorite Dies.*4/
	When I rate "Your Favorite Dies"'s "art" field with "1"
	Then I should see /Your Favorite Dies.*3/

Scenario: rate a comic so the averate is a decimal
	When I rate "Generic Comic"'s "story" field with "5"
	And I should see /Generic Comic.*5/
	And I click "Rate_Generic Comic"
	When I rate "Generic Comic"'s "story" field with "2"
	Then I should see /Cheddar.*3.5/
	When I rate "Generic Comic"'s "story" field with "1"
	Then I should see /Cheddar.*2.67/
