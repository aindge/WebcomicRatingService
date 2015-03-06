Feature: Add a comic to the list
    As a comic author 
    I want to be able to add my comic to the website
    So others can see it and review it

    Scenario: Add a comic named "Insert real comic name here"
 	    When I click "New Comic"
 	    Then I should see "New comic" 
 	    When I fill in "Name" with "Insert real comic name here"
 	    And I click "Create Comic"
 	    Then I should see "Comic was successfully created."
 	    And I click "Back"
 	    Then I should see "Insert real comic name here"

