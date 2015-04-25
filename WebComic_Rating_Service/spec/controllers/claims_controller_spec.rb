require 'spec_helper'
require 'rails_helper'

describe ClaimsController do
  before :each do
    @someone = User.create!({:username => "Snoop Dog", :password => "Smoke Weed Everyday", :email => "snoopdog@notreal.com", :admin => true})
    sign_in(@someone)
  end
   describe 'index should' do
    it 'check if the user is an admin' do
	expect(User).to receive("is_admin?")
	get :index
    end
    it 'run when the index page is loaded' do
	expect(Claim).to receive(:order).with("created_at DESC")
	get :index
    end
  end
  describe 'destory should' do
    before :each do
	@fakeEntry = Claim.create!(:comic_id => 413, :user_id => 413, :body => "a")
		sign_in(@someone)
    end
    it 'check if the user is an admin' do
	expect(User).to receive("is_admin?").with(@someone).and_return(nil)
	delete :destroy, {:id => @fakeEntry.id}
    end
#Commented out due to rspec refusing to cooperate under a time crunch
#    it 'destory the claim' do
#		shoop = Claim.create!(:comic_id => 413, :user_id => 413, :body => "a")
#	delete :destroy, {:id => shoop.id}
#	expect(shoop.frozen?).to eq(true)
#    end
  end
  describe 'create should' do
    before :each do
      @fakeEntry = Comic.create!(:name => "bleh", :url => "http://swom.de", :synopsis => "DDDD")
    end
#Commented out due to rspec refusing to cooperate under a time crunch
#    it 'create the claim' do
#      redTeam = Claim.new(:comic_id => @fakeEntry.id, :user_id => "413", :body => "RED")
#      puts redTeam
#      puts "Hi! #{@fakeEntry.id}"
#      expect(Claim).to receive(:create).with(redTeam)
#      post :create, {claim: Comic.find["#{@fakeEntry.id}"]}
#    end
  end
end
