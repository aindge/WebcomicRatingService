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
  end
  describe 'new should' do
    it 'make a new claim' do
	expect(Claim).to receive("new")
	get :new, {}
    end
  end
end
