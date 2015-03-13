Feature: Add a comic to the list
    As a comic author 
    I want to be able to add my comic to the website
    So others can see it and review it

    Scenario: Add a new comic (happy path)
		Given I am on the homepage
 	    When I add a comic "Fake Comic"
 	    Then I should see "Fake Comic"

    Scenario: Try to add an existing comic (sad path)
		Given I am on the homepage
		Then I add a comic "Fake Comic"
	    When I click "New Comic"
 	    Then I should see "New comic" 
 	    When I fill in "Name" with "Fake Comic"
	    And I fill in "comic[url]" with "www.something.com"
 	    And I click "Create Comic"
 	    Then I should see /Error: Comic "Fake Comic" Already Exists/

    Scenario: Try to add a nameless comic (sad path)
		Given I am on the homepage 	    
		When I click "New Comic"
 	    Then I should see "New comic" 
	    When I fill in "comic[url]" with "www.something.com"
 	    And I click "Create Comic"
 	    Then I should see "Required: Comic Name"
   
   Scenario: Try to add a non http url (sad path)
	    Given I am on the homepage 	    
	    When I click "New Comic"
 	    Then I should see "New comic"
	    When I fill in "Name" with "Fake Comic"
            And I fill in "comic[url]" with "BadURL" 
 	    And I click "Create Comic"
 	    Then I should see "Invalid URL"
