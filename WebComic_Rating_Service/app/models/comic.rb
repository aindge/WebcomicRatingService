#The Comic Database
class Comic < ActiveRecord::Base
	belongs_to :user
	has_many :claims

	validates :name, presence: true
	validates :synopsis, presence: true
	validates_format_of :url, :with => /http:\/\/..*[.]..*/, :on => [:create, :update]

	def self.search(search_condition, column, direction)
		user = User.where(['lower(username) LIKE lower(?)', "%#{search_condition}%"]).first
		if user != nil
			result = Comic.where(['lower(name) LIKE lower(?) OR lower(author) LIKE lower(?) OR lower(genre) LIKE lower(?) OR user_id LIKE ?', 
														"%#{search_condition}%", "%#{search_condition}%", "%#{search_condition}%", 
														"%{user.id}%"]).order(column + " " + direction)
		else
			result = Comic.where(['lower(name) LIKE lower(?) OR lower(author) LIKE lower(?) OR lower(genre) LIKE lower(?)', 
														"%#{search_condition}%", "%#{search_condition}%", "%#{search_condition}%"]).order(column + " " + direction)
		end
	end

	def check_and_fix_url
		return /http:\/\/..*[.]..*/.match url ? url : (/..*[.]..*/.match url ? "http://" << url : nil)
	end

	def format_author_links_string()
		result = self.author == nil ? "" : self.author
		if user_id != nil
			result << ", " if result != ""
			begin
				result << "#{link_to "#{User.find(user_id).username}", show_user_path(User.find(user_id))}"
			rescue
				result << "#{User.find(user_id).username}"
			end
		end
		return result
	end

end
