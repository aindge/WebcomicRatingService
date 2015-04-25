require 'spec_helper'
require 'rails_helper'

describe ClaimsController do
  before :each do
    @someone = User.create({:username => "Snoop Dog", :password => "Smoke Weed Everyday", :email => "snoopdog@notreal.com", :admin => true})
    @current_user = controller.stub(:current_user).and_return(@someone)
  end
   describe 'index should' do
    it 'check if the user is an admin' do
	expect(User).to receive("is_admin?").with(@current_user)
	get :index
    end
    it 'run when the index page is loaded' do
	expect(Claim).to receive(:order).with("created_at DESC")
	get :index
    end
  end
  describe 'destory should' do
    before :each do
	@fakeEntry = Claim.create(:comic_id => 413, :user_id => 413, :id => 413)
    end
    it 'check if the user is an admin' do
	expect(User).to receive("is_admin?").with(@current_user).and_return(nil)
	delete :destroy, {:id => "420"}
    end
    it 'destory the claim' do
	expect(Claim).to receive("destroy!").with("420").and_return(nil)
	delete :destroy, {:id => "420"}
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
