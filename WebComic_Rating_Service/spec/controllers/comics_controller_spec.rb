require 'spec_helper'
require 'rails_helper'

describe ComicsController do
	describe 'user sorting' do
		before :each do
			@fake_entry1 = Comic.create!(name: "Legit", id: "1", user_id: "1")
			@fake_entry2 = Comic.create!(name: "AlsoLegit", id: "2", user_id: "1")
			@fake_entry3 = Comic.create!(name: "NotLegit", id: "3", user_id: "2")
			@fake_user = User.create!(username: "Bob", id: "1", email: "whyverify@test.com", password: "somethingSharp")
		end
		it 'should add the comics into the comic register correctly' do
			controller.show_user(1)
			expect(@comics).to eq([@fake_entry1, @fake_entry2])
		end
	end
  describe 'ratings should,' do
    before :each do  
      @fakeEntry = double('fakeComic')
      @fakeEntry.stub(:name).and_return("Legit")
      @fakeEntry.stub(:id).and_return("420")
      @ratings = {:rating_art => "4", :rating_story => "1", :rating_overall => "3"}
			someone = User.create({:username => "generic_user", :password => "something", :email => "something@somewhere.com", :admin => false, :has_rated => {}})
			@current_user = controller.stub(:current_user).and_return(someone)
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
