Feature: Add a comic to the list
    As a comic author 
    I want to be able to add my comic to the website
    So others can see it and review it

    Scenario: Add a new comic (happy path)
		Given I am on the homepage
 	    When I click "New Comic"
 	    Then I should be on the Create New Comics page.
 	    When I fill in "Name" with "Fake Comic"
 	    And I click "Create Comic"
 	    Then I should see "Comic was successfully created."
 	    And I click "Back"
 	    Then I should see "Fake Comic"

    Scenario: Try to add an existing comic (sad path)
		Given I am on the homepage
		Then I add a comic "Fake Comic"
 	    Then I should see "Fake Comic"
	    When I click "New Comic"
 	    Then I should see "New comic" 
 	    When I fill in "Name" with "Fake Comic"
 	    And I click "Create Comic"
 	    Then I should see "Error: Comic Fake Comic Already Exists"

    Scenario: Try to add a null comic (sad path)
		Given I am on the homepage 	    
		When I click "New Comic"
 	    Then I should see "New comic" 
 	    And I click "Create Comic"
 	    Then I should see "Required: Comic Name"

