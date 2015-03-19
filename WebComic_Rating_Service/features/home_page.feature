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

#As a user in above feature

    Scenario: Try to register as a new user. (happy path) #iter2-1 3/19/15
        Given I am on the homepage
		And I click "Register"
		Then I should be on the Create New Account page
		When I fill in "Username" with "TestUser"
		And I fill in "Password" with "TestPassword"
		And I fill in "Confirm Password" with "TestPassword"
		And I fill in "Email" with "something@somewhere.com"
		And I click "Submit"
		Then I should be on the homepage
		And I should see "Success"
		And I should see "Hi, TestUser"

	Scenario: Try to register an existing username. (sad path)
		Given I am on the homepage
		And a user "TestUser" exists
		And I click "Register"
		Then I should be on the Create New Account page
		When I fill in "Username" with "TestUser"
		And I fill in "Password" with "TestPassword"
		And I fill in "Confirm Password" with "TestPassword"
		And I fill in "Email" with "something@somewhere.com"
		And I click "Submit"
		Then I should be on the Create New Account page
		Then I should see "User Already Exists"

	Scenario: Try to register conflicting passwords. (sad path)
		Given I am on the homepage
		And I click "Register"
		Then I should be on the Create New Account page
		When I fill in "Username" with "TestUser"
		And I fill in "Password" with "TestPassword"
		And I fill in "Confirm Password" with "NotTestPassword"
		And I fill in "Email" with "something@somewhere.com"
		And I click "Submit"
		Then I should be on the Create New Account page
		And I should see "Passwords do not match"

	Scenario: Login and logout with existing user
		Given I am on the homepage
		Then I add the test user
		Then I fill in "Username" with "TestUser"
		And I fill in "Password" with "TestPassword"
		Then I click "Log In"
		Then I should be on the homepage
		And I should see "Success"
		Then I click "Log Out"
		Then I should be on the homepage
		And I should see "Success"

