class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    #rating = params[:rating]
    #@all_ratings = Rating.find(rating)
  end

  def index
	
	sort_by = session[:sort_by] || params[:sort_by]	
	case		
		when params[:ratings] == nil && params[:title] == nil && params[:sort_by] == nil
			@checked = {"G"=>"1", "PG"=>"1", "PG-13"=>"1", "R"=>"1"}
	  	@movies = Movie.all
 		  @all_ratings = Movie.all_ratings
		when params[:ratings] != nil
			session[:ratings] = @checked = params[:ratings]
			mine = []
			@checked.each do |key,value|
				mine.push(key)
			end
			session[:mine] = mine
			@movies = Movie.where(rating: [session[:mine]])
			@all_ratings = Movie.all_ratings
		when params[:sort_by] == "title" && session[:ratings] != nil
			@movies = Movie.where(rating: [session[:mine]]).order(:title)
			@tit_class = 'hilite'
			#this won't work here....hmmm  sort_by = session[:sort_by] = params[:sort_by]
			@all_ratings = Movie.all_ratings
			@checked = session[:ratings]
		when params[:sort_by] == "release_date" && session[:ratings] != nil
			@movies = Movie.where(rating: [session[:mine]]).order(:release_date)
			@rel_class = 'hilite'		
			@all_ratings = Movie.all_ratings
			@checked = session[:ratings]
		end
		
		if params[:ratings] != session[:ratings] or session[:sort_by] != params[:sort_by]
			session[:sort_by] = sort_by
			session[:ratings] = @checked
			redirect_to :sort_by => sort_by, :ratings => @checked and return
		end
		
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
