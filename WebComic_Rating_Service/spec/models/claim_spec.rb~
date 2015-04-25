require 'rails_helper'

RSpec.describe Claim, :type => :model do
  describe "validation" do
		it "should fail if it has nothing" do
			smoos = Claim.new()
			expect(smoos.invalid?).to eq(true)
		end
		it "should pass if it has a body, comic, and user" do
			moose = Claim.new(:body => "a", :comic_id => 1, :user_id => 1)
			expect(moose.valid?).to eq(true)
		end
	end
end
