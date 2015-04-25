Then(/^I add a comic "(.*?)"$/) do |comic|
  steps %Q{
    Given I am on the homepage
    When I click "New Comic"
    Then I should be on the Create New Comics page.
    When I fill in "Name" with "#{comic}"
    And I fill in "comic[url]" with "http://www.comic.com"
    And I fill in "Synopsis" with "Bluh"
    And I click "Create Comic"
    And I click "Back"
  }
end

Given(/^a user "(.*?)" exists$/) do |user|
  steps %Q{  
	Given I am on the homepage
		And I click "Register"
		Then I should be on the Create New Account page
		When I fill in "Username" with "#{user}"
		And I fill in "Password" with "#{user}"
		And I fill in "user[password_confirmation]" with "#{user}"
		And I fill in "Email" with "something@somewhere.com"
		And I click "Sign up"
		Then I should be on the home page
		Then I click "Log out"
		Then I should see "you're not logged in"
	}
end

Given /the following users exist/ do |user_table|
  user_table.hashes.each do |user|
    User.create!(user)
  end
end

Given /the following comics exist/ do |comic_table|
  comic_table.hashes.each do |comic|
    newComic = comic.merge({:synopsis => "bluh", :rating_art => "0", :rating_story => "0", :rating_overall => "0", :rates => "0"})
    Comic.create!(newComic)
  end
end

Given(/^I am logged in as "(.*?)"$/) do |user|
  steps %Q{
    Given I am on the homepage
    When I click "Log in"
    Then I fill in "Username" with "#{user}"
    And I fill in "Password" with "#{user}"
    Then I click "Sign in"
    Then I should see "#{user}"
  }
end

Given(/^there is a comic "(.*?)" made by "(.*?)"$/) do |comic, user|
    newComic = ({:name => "#{comic}", :name => "#{user}", :name => "http://www.#{comic}.com", :synopsis => "bluh", :rating_art => "0", :rating_story => "0", :rating_overall => "0", :rates => "0"})
    Comic.create!(newComic)
end

When (/^I rate "(.*?)"'s "(.*?)" field with "(.*?)"$/) do |comic, field, value|
  steps %Q{
    Given I am on the homepage
    When I click "Rate" for comic "#{comic}"
    And I select "#{value}" from "Rate the #{field}"
    And I press "Rate the comic!"
  }
end

Then (/^I switch to user "(.*?)"$/) do |user|
  steps %Q{
    Given I am on the homepage
    When I click "Log out"
    And I am logged in as "#{user}"
  }
end
