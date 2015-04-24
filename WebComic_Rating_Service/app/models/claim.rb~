class Claim < ActiveRecord::Base
	belongs_to :user
	belongs_to :comic
	
	validates :user_id, presence: true
	validates :comic_id, presence: true
	validates :body, presence: true
end
