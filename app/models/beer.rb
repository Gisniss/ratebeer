class Beer < ActiveRecord::Base

	#include RatingAverage

	belongs_to :brewery
	has_many :ratings

  def average_rating
	sana = "rating"
	"Has #{ratings.count} #{sana.pluralize(ratings.count)}, average #{ratings.average(:score)}"

  end

  def panimo
	a = self.brewery_id
	b = Brewery.find_by id:a
	"#{b.name}"
  end

end
