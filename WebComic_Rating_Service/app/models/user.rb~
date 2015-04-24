#User database
class User < ActiveRecord::Base
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

	def check_has_rated?(num)
	    hasRated = self.has_rated[num]
	    return hasRated.nil? ? false : hasRated
	end

	def record_rating(num)
		if self.has_rated == nil		
			update_attributes!(:has_rated => {num => true})
		else
			update_attributes!(:has_rated => self.has_rated.merge({num => true}))
		end
	end
end
