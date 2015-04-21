require 'spec_helper'
require 'rails_helper'

describe User do
	describe 'Usernames' do
		it 'should allow a legitmate name to work' do
			zoosmell = User.create({:username => "Zoosmell", :password => "DoTheWindyThing", :email => "thewindything@notreal.com"})
			expect(zoosmell).to be_valid
		end
		it 'should not allow copycats' do
			pooplord = User.create({:username => "Pooplord", :password => "DoTheWindyThing", :email => "thewindything@notreal.com"})
			expect(pooplord).to be_valid
			copycat = User.create({:username => "Pooplord", :password => "IAMBETTERTHANYOU", :email => "therealhacker@notreal.com"})
			expect(copycat).to be_invalid
		end
	end
	describe 'Admin privileges' do
		it "should be able to tell if it's an admin" do
			regUser = User.create({:username => "generic_user", :password => "something", :admin => false})
			admin = User.create({:username => "generic_user", :password => "superSecret", :admin => true})
			expect(User.is_admin?(regUser)).to eq(false)
			expect(User.is_admin?(admin)).to eq(true)
			expect(User.is_admin?(nil)).to eq(false)
		end
	end
end
