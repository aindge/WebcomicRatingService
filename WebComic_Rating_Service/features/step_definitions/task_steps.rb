Given /there is a comic named  "(.*)"/ do |comic|
  steps %Q{
    Given I am on the Create New Comic page
    When I fill in "Name" with "#{comic}"
    And I click "Create Comic"
    And I click "Back"
  }
end
