class User < ActiveRecord::Base
include RatingAverage

  validates :username, uniqueness: true, length: { minimum: 3 }, length: { maximum: 15}
  has_many :ratings
end
