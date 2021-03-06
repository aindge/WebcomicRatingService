Feature: Allow logged in users to edit and delete their comics
    As a sysadmin 
    I want to be able to remove duplicates, spam, or non-comic entries from the list 
    So that one person will not be able to flood the listings with a duplicate or non-comic entry. 


Background: users have been added to the db

  Given the following users exist:
	| username	| password 	|  email		| admin |
	| TestUser	| TestUser  	| testeamail@gmail.com  | false |
	| Sysadmin	| Sysadmin	| testadmin@gmail.com   | true  | 

	Scenario: Delete a comic that you have permission to delete(happy path)
		Given I am on the homepage
		And I am logged in as "TestUser"
		Then I should be on the homepage
		And there is a comic "TestComic" made by "TestUser"
		Then I go to the homepage
		And I should see "TestComic"
		When I click "Delete" for comic "TestComic"
		Then I should be on the homepage
		And I should see "was successfully deleted."

	Scenario: Edit a comic that you have permission to edit(happy path)
		Given I am on the homepage
 		And I am logged in as "TestUser"
		And there is a comic "TestComic" made by "TestUser"
		When I click "Edit" for comic "TestComic"
		Then I should see "Editing Comic"
		When I fill in "Name" with "TestComicRevised"
		And I click "Update Comic"
		Then I should see "was successfully changed"

	Scenario: Try to delete a comic whiel not logged in(sad path)
		Given I am on the homepage
		Then I should not see "Delete"	
		Then I should not see "Edit"		

	Scenario: Try to delete a comic that isn't yours(sad path)
		Given I am on the homepage
 		And I am logged in as "TestUser"
		And there is a comic "NachoComic" made by "BadPuns"
		Then I should not see "Delete_NachoComic"

	Scenario: Try to edit a comic that isn't yours(sad path)
		Given I am on the homepage
 		And I am logged in as "TestUser"
		And there is a comic "NachoComic" made by "BadPuns"
		Then I should not see "Edit_NachoComic"

	Scenario: Delete a comic as and admin(happy path)
		Given I am on the homepage
 		And I am logged in as "Sysadmin"
		And there is a comic "TestComic" made by "TestUser"
		When I click "Delete" for comic "TestComic"
		And I should see "was successfully deleted."

	Scenario: Edit a comic as an admin(happy path)
		Given I am on the homepage
 		And I am logged in as "Sysadmin"
		And there is a comic "TestComic" made by "TestUser"
		When I click "Edit" for comic "TestComic"
		Then I should see "Editing Comic"
		When I fill in "Name" with "TestComic Revised!"
		And I click "Update Comic"
		Then I should see "was successfully changed"

