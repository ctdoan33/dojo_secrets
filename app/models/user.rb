class User < ActiveRecord::Base
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :name, presence:true
	validates :email, uniqueness:{case_sensitive:false}, format:{with:EMAIL_REGEX}
	after_validation do
		self.email = email.downcase
	end
	has_secure_password
	has_many :secrets
	has_many :likes, dependent: :destroy
	has_many :secrets_liked, through: :likes, source: :secret
end
