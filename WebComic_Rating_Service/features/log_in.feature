Feature: Allow a user to create and use an account
    As a user 
    I want to be able to have my own login account 
    So I can keep and save my preferences and comics 

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