class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    #rating = params[:rating]
    #@all_ratings = Rating.find(rating)
  end

  def index
	
		sort_by = params[:sort_by] || session[:sort_by]
	
		case sort_by
			when "title"
				ordered = {:order => :title}
				@tit_class = 'hilite'
			when "release_date"
				ordered = {:order => :release_date}
				@rel_class = 'hilite'						
		end
	
		@all_ratings = Movie.all_ratings
		@checked = params[:ratings] || session[:ratings] || {}
		
		if @checked == {}
			@checked = Hash[@all_ratings.map {|rating| [rating, rating]}]
		end
	
		if params[:ratings] != session[:ratings] or params[:sort_by] != session[:sort_by]
			session[:sort_by] = sort_by
			session[:ratings] = @checked
			redirect_to :sort_by => sort_by, :ratings => @checked and return
		end
			@movies = Movie.find_all_by_rating(@checked.keys, ordered)
	
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
