Feature: Allow a user to rate comics
    As a user 
    I want to be able to rate comics
    So I can I can tell people of good comics and warn others of bad ones

Background: comics have been added to database

  Given the following tasks exist:
  | comic               | author       | url                |
  | Cheddar             | Nacho Comics | www.something.com  |
  | Poo Comic           | Crap Writer  | www.something.com  |
  | Swiss               | Nacho Comics | www.something.com  |
  | American            | Nacho Comics | www.something.com  |
  | Cruddy Comic        | Crap Writer  | www.something.com  |
  | Original Comic      | The Original | www.something.com  |
  | Your Favorite Dies  | Bad Man      | www.something.com  |
  | Genric Comic        | Someone      | www.something.com  |
  | Test                | Test         | www.something.com  |

  And I am on the home page

Scenario: rate a comic initially
	When I click on "Cheddar_vote"
	And I select "5"
	Then I should be on the homepage
	And I should see /Cheddar.*5/

Scenario: rate a comic again
	When I click on "Cheddar_vote"
	And I select "5"
	Then I should be on the homepage
	And I should see /Cheddar.*5/
	And I click on "Cheddar_vote"
	And I select "3"
	Then I should be on the homepage
	And I should see /Cheddar.*4/
	When I click on "Cheddar_vote"
	And I select "1"
	Then I should be on the homepage
	And I should see /Cheddar.*3/

Scenario: rate a comic so the averate is a decimal
	When I click on "Cheddar_vote"
	And I select "5"
	Then I should be on the homepage
	And I should see /Cheddar.*5/
	And I click on "Cheddar_vote"
	And I select "2"
	Then I should be on the homepage
	And I should see /Cheddar.*3.5/
	When I click on "Cheddar_vote"
	And I select "1"
	Then I should be on the homepage
	And I should see /Cheddar.*2.67/
