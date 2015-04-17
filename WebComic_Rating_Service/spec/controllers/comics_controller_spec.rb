require 'spec_helper'
require 'rails_helper'

describe ComicsController do
  describe 'ratings should' do
    before :each do
	@fakeEntry = double('fakeComic')
	@fakeEntry.stub(:name).and_return("Legit")
	@fakeEntry.stub(:id).and_return("420")
        @fakeEntry.stub("rating_art".to_sym).and_return(2)
        @fakeEntry.stub("rating_story".to_sym).and_return(1)
        @fakeEntry.stub("rating_overall".to_sym).and_return(3)
        @fakeEntry.stub("rates".to_sym).and_return(1)
	@fakeEntry.stub("update".to_sym).and_return(0)
        @ratings = {:rating_art => "4", :rating_story => "1", :rating_overall => "3"}

    end
    it 'call the rating method' do
      expect(Comic).to receive(:find).with("420").and_return(@fakeEntry)
      put :reviseRate, {:id => "420", :ratings => @ratings, :controller => "comics"}
    end 
  end
end