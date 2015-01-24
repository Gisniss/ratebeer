class Rating < ActiveRecord::Base
	belongs_to :beer
  def to_s
	b = Beer.find_by id:self.beer_id
	"#{b.name} #{self.score}"
  end

  def new
	@rating = Rating.new
  end

  def create
	Rating.create params.require(:rating).permit(:score, :beer_id)
	redirect_to ratings_path
  end

end
