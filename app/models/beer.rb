class Beer < ActiveRecord::Base

	include RatingAverage
	validates :name, length: { minimum: 1 }

	belongs_to :brewery
	has_many :ratings, dependent: :destroy
	has_many :raters, through: :ratings, source: :user

  def average
	return 0 if ratings.empty?
	ratings.map { |r| r.score }.sum / ratings.count.to_f
  end

  
  def to_s
	"#{name}, #{brewery.name}"
  end

end
