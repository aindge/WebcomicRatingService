describe Comic do
	@synopsis = "Why didn't you fix your own tests..."
	@url = "http://www.example.com"
	describe 'search' do
		it 'should call the search function' do
			awesome1 = double('Comic', :name => "Awesome Sauce", :author => "Someone", :id => "1", :url => @url, :synopsis => @synopsis)
			awesome2 = double('Comic', :name => "Something Else", :author => "Awesome Sauce", :id => "2", :url => @url, :synopsis => @synopsis)
			awesome3 = double('Comic', :name => "Not Cool", :author => "Super Uncool", :id => "3", :url => @url, :synopsis => @synopsis)
			expect(awesome1.name).to eq("Awesome Sauce")
			expect(awesome2.author).to eq("Awesome Sauce")
			expect(awesome3.name).to_not eq("Awesome Sauce")
		end
		it 'should find the appropriate records' do
			awesome1 = Comic.create(:name => "Awesome Sauce", :author => "Someone", :id => "1", :url => @url, :synopsis => @synopsis)
			awesome2 = Comic.create(:name => "Something Else", :author => "Awesome Sauce", :id => "2", :url => @url, :synopsis => @synopsis)
			awesome3 = Comic.create(:name => "Not Cool", :author => "Super Uncool", :id => "3", :url => @url, :synopsis => @synopsis)
			expect(Comic.search("Awesome Sauce", "name", "asc")).to eq([awesome1, awesome2])
		end
	end
	describe 'formatting author names' do
		it "should return the author's name as a link" do
			somebody = User.create!(:username => "Bob", :password => "thisiseightcharacters", :email => "whyverification@tests.org", :id => 1, :url => @url, :synopsis => @synopsis)
			awesome = Comic.create!(:name => "Awesome Sauce", :author => "Someone", :user_id => 1, :url => @url, :synopsis => @synopsis)
			expect(awesome.format_author_links_string).to eq("Someone, Bob")
		end
		it "shouldn't append any link if there is no User associated with the comic" do
			awesome = Comic.create(:name => "Awesome Sauce", :author => "Someone", :user_id => nil, :url => @url, :synopsis => @synopsis)
			expect(awesome.format_author_links_string).to eq("Someone")
		end
	end
end
