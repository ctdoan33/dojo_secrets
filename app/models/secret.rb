class Secret < ActiveRecord::Base
	validates :content, :user, presence:true
	belongs_to :user
	has_many :likes
	has_many :users, through: :likes
end
