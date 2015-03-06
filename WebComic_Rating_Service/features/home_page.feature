Feature: Add a comic to the list
    As a comic author 
    I want to be able to add my comic to the website
    So others can see it and review it

    Scenario: Add a new comic (happy path)
 	    When I click "New Comic"
 	    Then I should see "New comic" 
 	    When I fill in "Name" with "Paradox Space"
 	    And I click "Create Comic"
 	    Then I should see "Comic was successfully created."
 	    And I click "Back"
 	    Then I should see "Paradox Space"

    Scenario: Try to add an existing comic (sad path)
 	    Given that there is a comic called "Homestuck"
	    When I click "New Comic"
 	    Then I should see "New comic" 
 	    When I fill in "Name" with "Homestuck"
 	    And I click "Create Comic"
 	    Then I should see "That comic already exists"

    Scenario: Try to add a null comic (sad path)
 	    When I click "New Comic"
 	    Then I should see "New comic" 
 	    And I click "Create Comic"
 	    Then I should see "You need to at least enter a comic name"

