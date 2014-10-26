class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date
  
  def self.all_ratings
  	ratings = []
  	Movie.all.each do |movie|
  		if ratings.include?(movie.rating) == false
  			ratings.push(movie.rating)
  		end
  	end
  	return ratings.sort
  end
end
