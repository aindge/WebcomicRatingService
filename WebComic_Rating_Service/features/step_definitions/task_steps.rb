Then(/^I add a comic "(.*?)"$/) do |comic|
  steps %Q{
    Given I am on the homepage
    When I click "New Comic"
    Then I should be on the Create New Comics page.
    When I fill in "Name" with "#{comic}"
    And I fill in "comic[url]" with "www.something.com"
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
		And I fill in "Password" with "TestPassword"
		And I fill in "user[password_confirmation]" with "TestPassword"
		And I fill in "Email" with "something@somewhere.com"
		And I click "Sign up"
		Then I should be on the home page
		Then I click "Log out"
	}
end

Given /the following users exist/ do |user_table|
  user_table.hashes.each do |user|
    User.create!(user)
  end
end

Given /the following comics exist/ do |comic_table|
  comic_table.hashes.each do |comic|
    Comic.create!(comic)
  end
end

Given(/^I am logged in as "(.*?)"$/) do |user|
  steps %Q{
    Given I am on the homepage
    When I click "Log in"
    Then I fill in "Username" with "#{user}"
    And I fill in "Password" with "#{user}"
    Then I click "Sign in"
  }
end

Given(/^there is a comic "(.*?)" made by "(.*?)"$/) do |comic, user|
  steps %Q{
		Given I am on the homepage
		When I click "New Comic"
		And I fill in "Name" with "#{comic}"
		And I fill in "Author" with "#{user}"
		And I fill in "comic[url]" with "www.test.com"
		And I press "Create Comic"
		And I click "Back"
		Then I should be on the homepage
		And I should see "#{comic}"
	}
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
