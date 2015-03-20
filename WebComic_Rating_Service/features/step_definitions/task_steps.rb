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
  User.new(username:"#{user}")
end

Then(/^I add the test user$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^that I am logged in as "(.*?)"$/) do |user|
  steps %Q{
    Given I am on the homepage
    And a user "#{user}" exists
    Then I fill in "Username" with "#{user}"
    And I fill in "Password" with "#{user}"
    Then I click "Log In"
  }
end

Given(/^there is a comic "(.*?)" made by "(.*?)"$/) do |comic, user|
  Comic.new({:name => "#{comic}", :author => "#{user}"})
end
