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
		And I fill in "user[password_confirmation]" with "TestPassword"
		And I fill in "Email" with "something@somewhere.com"
		And I click "Sign up"
		Then I should be on the homepage
		And I should see "successfully"
		And I should see "Hi, TestUser"

	Scenario: Try to register an existing username. (sad path)
		Given I am on the homepage
		And a user "TestUser" exists
		Then I should be on the homepage
		And I click "Register"
		Then I should be on the Create New Account page
		When I fill in "Username" with "TestUser"
		And I fill in "Password" with "TestPassword"
		And I fill in "user[password_confirmation]" with "TestPassword"
		And I fill in "Email" with "something@somewhere.com"
		And I click "Sign up"
		Then I should see "taken"

	Scenario: Try to register conflicting passwords. (sad path)
		Given I am on the homepage
		And I click "Register"
		Then I should be on the Create New Account page
		When I fill in "Username" with "TestUser"
		And I fill in "Password" with "TestPassword"
		And I fill in "user[password_confirmation]" with "NotTestPassword"
		And I fill in "Email" with "something@somewhere.com"
		And I click "Sign up"
		And I should see "match"

	Scenario: Login and logout with existing user
		Given I am on the homepage
		And a user "TestUser" exists
		Then I click "Log in"
		Then I fill in "Username" with "TestUser"
		And I fill in "Password" with "TestUser"
		Then I click "Sign in"
		Then show me the html
		Then I should be on the homepage
		And I should see "success"
		Then I click "Log out"
		Then I should be on the homepage
		And I should see "success"
