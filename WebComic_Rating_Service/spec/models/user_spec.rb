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
	describe 'Users can only rate once per comic' do
		it "should append to the has_rated hash" do
			someUser = User.create!({:username => "generic_user", :password => "something", :email => "something@somewhere.com", :admin => false, :has_rated => {}})
			someComic = Comic.create!({:name => "best comic", :author => "best artist", :rating_art => 1, :rating_story => 2, :rating_overall => 3, :url => "http://www.example.com", :synopsis => "Shush you."})
			expect(someUser.check_has_rated?(someComic)).to eq(false)
			someUser.record_rating(someComic, {:ratings_art => 1, :ratings_story => 2, :ratings_overall => 3})
			expect(someUser.check_has_rated?(someComic)).to eq(true)
			expect(someUser.has_rated).to eq({someComic.id=>[1.0, 2.0, 3.0]})
		end
	end
end
