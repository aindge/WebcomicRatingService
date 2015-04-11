Feature: Search for comics
	As a newbie to online comics
	I want to seach for specific comics
	So that I can find the best comics to start off with

Background: comics have been added to database

  Given the following comics exist:
  | name                | author       | url                |genre   |
  | Cheddar             | Nacho Comics | www.something.com  |cheesy  |
  | Poo Comic           | Crap Writer  | www.something.com  |comedy  |
  | Swiss               | Nacho Comics | www.something.com  |cheesy  |
  | American            | Nacho Comics | www.something.com  |cheesy  |
  | Cruddy Comic        | Crap Writer  | www.something.com  |comedy  |
  | Original Comic      | The Original | www.something.com  |boring  |
  | Your Favorite Dies  | Bad Man      | www.something.com  |mean    |
  | Genric Comic        | Someone      | www.something.com  |boring  |
  | Test                | Test         | www.something.com  |boring  |

  And I am on the home page

Scenario: Search by name
	When I fill in "Search Bar" with "Cheddar"
	And I press "Search"
	Then I should see "Cheddar"
	And I should not see "Swiss"
	And I should not see "Test"
	And I should not see "American"

	When I fill in "Search Bar" with "Original Comic"
	And I press "Search"
	Then I should see "Original Comic"
	And I should not see "Swiss"
	And I should not see "Test"
	And I should not see "Cheddar"

Scenario: Search by author
	When I fill in "Search Bar" with "Nacho Comics"
	And I press "Search"
	Then I should see "Cheddar"
	And I should see "Swiss"
	And I should not see "Test"
	And I should not see "Your Favorite Dies"

Scenario: Search by genre
	When I fill in "Search Bar" with "boring"
	And I press "Search"
	Then I should see "Original Comic"
	And I should see "Genric Comic"
	And I should see "Test"
	And I should not see "Cheddar"
	And I should not see "Your Favorite Dies"

Scenario: Search found nothing (sad path)
	When I fill in "Search Bar" with "Hamburgers"
	And I press "Search"
	Then I should see "Nothing found with that entry. Check your spelling maybe?"

Scenario: Mess with capitalization (sad path)
	When I fill in "Search Bar" with "ChEeSy"
	And I press "Search"
	Then I should see "Cheddar"
	And I should see "American"
	And I should not see "Cruddy Comic"
	And I should not see "Your Favorite Dies"
