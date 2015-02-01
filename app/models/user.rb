class User < ActiveRecord::Base
include RatingAverage

has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3 }, length: { maximum: 15}
  validates :password, lenght: { minimum: 4 }, format: { with: /(?=.*[0-9])(?=.*[A-Z])().+/i, message: "Must contain at least one capital letter and one number!" }
  has_many :ratings
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships

	def to_s
	  "#{self.username}"
	end
end

