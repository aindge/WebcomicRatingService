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
	delete :destroy, {:id => "1"}
    end
    it 'destory the claim' do
	expect(@fakeEntry).to receive("destroy!").and_return(nil)
	delete :destroy, {:id => "1"}
    end
  end
  describe 'create should' do
    before :each do
      @fakeEntry = double('TRASH')
      @fakeEntry.stub(:name).and_return("Garbage")
      @fakeEntry.stub(:id).and_return("420")
      @fakeEntry.stub(:permit)
      @fakeEntry.stub(:url).and_return("www.TRASH.com")
      @fakeEntry.stub(:synopsis).and_return("Absolute filth")
    end
    it 'create the claim' do
      expect(Claim).to receive(:new).with(@fakeEntry)
      post :create, {:claim => @fakeEntry}
    end
  end
end
