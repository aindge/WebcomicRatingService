require 'spec_helper'
require 'rails_helper'

describe ComicsController do
  describe 'sort should' do
    it 'run when the index page is loaded' do
      expect(Comic).to receive(:order).with("name asc")
      get :index
    end
    context 'use the helpers to' do
      it 'call a custom ' do
        expect(Comic).to receive(:order).with("genre desc")
        get :index, {:direction => "desc", :sort => "genre"}
      end
      it 'use only default order with specified item' do
        expect(Comic).to receive(:order).with("genre asc")
        get :index, {:sort => "genre"}
      end
      it 'use only default item with specified order' do
        expect(Comic).to receive(:order).with("name desc")
        get :index, {:direction => "desc"}
      end
      it 'use default order for nonsensical item' do
        expect(Comic).to receive(:order).with("name asc")
        get :index, {:direction => "turnways"}
      end
      it 'use default item for nonsensical item' do
        expect(Comic).to receive(:order).with("name asc")
        get :index, {:sort => "zoosmell"}
      end
    end
  end

  describe 'ratings should,' do
    before :each do  
      @fakeEntry = double('fakeComic')
      @fakeEntry.stub(:name).and_return("Legit")
      @fakeEntry.stub(:id).and_return("420")
      @ratings = {:rating_art => "4", :rating_story => "1", :rating_overall => "3"}
      @someone = User.create({:username => "generic_user", :password => "something", :email => "something@somewhere.com", :admin => false, :has_rated => {}})
      @current_user = controller.stub(:current_user).and_return(@someone)
    end
    context 'given a previous rating,' do
        before :each do  
          @fakeEntry.stub("rating_art".to_sym).and_return(2)
          @fakeEntry.stub("rating_story".to_sym).and_return(1)
          @fakeEntry.stub("rating_overall".to_sym).and_return(3)
          @fakeEntry.stub("rates".to_sym).and_return(1)
	  @result = {:rates => 2, :rating_art => 3, :rating_story=> 1, :rating_overall => 3}
      end

      it 'call the rating method' do
        expect(Comic).to receive(:find).with("420").and_return(@fakeEntry)
        @fakeEntry.stub("update".to_sym).and_return(0)
        put :reviseRate, {:id => "420", :ratings => @ratings, :controller => "comics"}
      end

      it 'get correct results' do
        expect(Comic).to receive(:find).with("420").and_return(@fakeEntry)
        @fakeEntry.stub("update".to_sym).with(@result).and_return(0)
        put :reviseRate, {:id => "420", :ratings => @ratings, :controller => "comics"}
      end
    end

    context 'given no previous rating,' do
      before :each do  
        @fakeEntry.stub("rating_art".to_sym).and_return(nil)
        @fakeEntry.stub("rating_story".to_sym).and_return(nil)
        @fakeEntry.stub("rating_overall".to_sym).and_return(nil)
        @fakeEntry.stub("rates".to_sym).and_return(nil)
	  		@result = {:rates => 1, :rating_art => 4, :rating_story=> 1, :rating_overall => 3}
      end
      it 'get correct results' do
        expect(Comic).to receive(:find).with("420").and_return(@fakeEntry)
        @fakeEntry.stub("update".to_sym).with(@result).and_return(0)
        put :reviseRate, {:id => "420", :ratings => @ratings, :controller => "comics"}
      end
    end
  end
end
