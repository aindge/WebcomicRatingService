#The Comic Database
class Comic < ActiveRecord::Base

def self.search(search_condition)
	return Comic.where(['lower(name) LIKE lower(?) OR lower(author) LIKE lower(?) OR lower(genre) LIKE lower(?)', "%#{search_condition}%", 
																																			"%#{search_condition}%", 
																																			"%#{search_condition}%"])
end

end
