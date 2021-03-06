Feature: Test the update feature


Background: users have been added to the db

  Given the following users exist:
	| username	| password 			|  email		|
	| TestUser	| TestUser  		| testeamail@gmail.com  |
	| Sysadmin	| Sysadmin			| testadmin@gmail.com | 

	Scenario: Edit a comic(happy path)
		Given I am on the homepage
 		And I am logged in as "TestUser"
		And there is a comic "TestComic" made by "TestUser"
		When I click "Edit" for comic "TestComic"
		Then I should see "Editing Comic"
		When I fill in "Name" with "Bluh"
		And I fill in "comic[url]" with "http://www.example.com"
		And I click "Update Comic"
		Then I should see "was successfully changed"

	Scenario: Empty the URL slot(sad path)
		Given I am on the homepage
 		And I am logged in as "TestUser"
		And there is a comic "TestComic" made by "TestUser"
		When I click "Edit" for comic "TestComic"
		Then I should see "Editing Comic"
		When I fill in "Name" with "Bluh"
		And I fill in "comic[url]" with ""
		And I click "Update Comic"
		Then I should see "invalid"

	Scenario: Empty the Name slot(sad path)
		Given I am on the homepage
 		And I am logged in as "TestUser"
		And there is a comic "TestComic" made by "TestUser"
		When I click "Edit" for comic "TestComic"
		Then I should see "Editing Comic"
		When I fill in "Name" with ""
		And I click "Update Comic"
		Then I should see "invalid"
