Feature: Allow logged in users to edit and delete their comics
    As a sysadmin 
    I want to be able to remove duplicates, spam, or non-comic entries from the list 
    So that one person will not be able to flood the listings with a duplicate or non-comic entry. 

	Scenario: Delete a comic that you have power over(happy path)
 		Given that I am logged in as "TestUser"
		And there is a comic "TestComic" made by "TestUser"
		When I click "Delete_TestComic"
		Then I should see "Are you sure?"

	Scenario: Edit a comic that you have power over(happy path)
 		Given that I am logged in as "TestUser"
		And there is a comic "TestComic" made by "TestUser"
		When I click "Edit_TestComic"
 	    Then I should see the Edit comic page 
		When I fill in "Name" with "TestComicRevised"
		And I click "Update Comic"
		Then I should see "TestComicRevised"

	Scenario: Delete a comic as admin(happy path)
 		Given that I am logged in as "Sysadmin"
		And there is a comic "TestComic" made by "TestUser"
		When I click "Delete_TestComic"
		Then I should see "Are you sure?"
		
	Scenario: Try to delete a comic that isn't yours(sad path)
 		Given that I am logged in as "TestUser"
		And there is a comic "NachoComic" made by "BadPuns"
		Then I should not see "Delete_NachoComic"

	Scenario: Try to edit a comic that isn't yours(sad path)
 		Given that I am logged in as "TestUser"
		And there is a comic "NachoComic" made by "BadPuns"
		Then I should not see "Edit_NachoComic"
