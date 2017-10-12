class Like < ActiveRecord::Base
	validates :user, :secret, presence:true
	belongs_to :user
	belongs_to :secret
end
