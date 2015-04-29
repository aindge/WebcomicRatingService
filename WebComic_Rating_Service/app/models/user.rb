#User database
class User < ActiveRecord::Base
	
	has_many :comics
	has_many :users	
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username] 

  validates :username,
	    :presence => true,
	    :uniqueness => true

	# Turns the hasRated column into a hash.
	# Hash is {comic_id => boolean}
	serialize :has_rated, Hash
  
	def is_author_of(comic)
		return username == comic.author
	end

	def self.is_admin?(user)	
		# This is a class method so that if this is accidentally called with nil 
		#	nothing explodes, since for the most part nil == false
		# In case a user isn't logged in.
		return user.nil? ? false : user.admin
	end

	def check_has_rated?(comic)
	    hasRated = self.has_rated[comic.id]
	    return hasRated.nil? ? false : true
	end

	def get_has_rated(comic)
	    return self.has_rated[comic.id]
	end

	def record_rating(comic, art, story, overall)
		@array = [art, story, overall]
		if self.has_rated[comic.id].nil?
			update_attributes!(:has_rated => {comic.id => @array})
		else
			update_attributes!(:has_rated => self.has_rated.merge({comic.id => @array}))
		end
	end
	#def getValue
		#if self.has_rated[comic.id].nil?
			#{comic.id => [comic.rating_art, comic.rating_story, comic.rating_overall]}
		#else
			#self.has_rated.merge({comic.id => [comic.rating_art, comic.rating_story, comic.rating_overall]}
	#end
end
