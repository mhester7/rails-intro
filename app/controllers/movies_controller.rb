class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    #rating = params[:rating]
    #@all_ratings = Rating.find(rating)
  end

  def index
  
  #G
	  if params[:ratings] == {"G"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.find(:all, :conditions => {rating: "G"})#Movie.all
			session[:rating] = params[:ratings]
			#session[:movies] = @movies
	#G, PG  	
	  elsif params[:ratings] == {"G"=>"0", "PG"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ?", "G","PG") #.order("title ASC")
	  	session[:rating] = params[:ratings]
	#G, PG, PG-13
	  elsif params[:ratings] == {"G"=>"0", "PG"=>"0", "PG-13"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ? OR rating = ?", "G","PG","PG-13") #.order("title ASC")
			session[:rating] = params[:ratings]
	#G, PG, PG-13, R
	  elsif params[:ratings] == {"G"=>"0", "PG"=>"0", "PG-13"=>"0", "R"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ? OR rating = ? OR rating = ?", "G","PG","PG-13","R") #.order("title ASC")
			session[:rating] = params[:ratings]
	#G, PG-13
	  elsif params[:ratings] == {"G"=>"0", "PG-13"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ?", "G","PG-13") #.order("title ASC")
			session[:rating] = params[:ratings]
	#G, R
	  elsif params[:ratings] == {"G"=>"0", "R"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ?", "G","R") #.order("title ASC")
			session[:rating] = params[:ratings]
	#PG
	  elsif params[:ratings] == {"PG"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ?", "PG") #.order("title ASC")
			session[:rating] = params[:ratings]
	#PG, PG-13
	  elsif params[:ratings] == {"PG"=>"0", "PG-13"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ?", "PG","PG-13") #.order("title ASC")
			session[:rating] = params[:ratings]
	#PG, PG-13, R
	  elsif params[:ratings] == {"PG"=>"0", "PG-13"=>"0", "R"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ? OR rating = ?", "PG","PG-13", "R") #.order("title ASC")
			session[:rating] = params[:ratings]
	#PG, R
	  elsif params[:ratings] == {"PG"=>"0", "R"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ?", "PG","R") #.order("title ASC")
			session[:rating] = params[:ratings]
	#PG-13
	  elsif params[:ratings] == {"PG-13"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ?", "PG-13") #.order("title ASC")
			session[:rating] = params[:ratings]
	#PG-13, R	
	  elsif params[:ratings] == {"PG-13"=>"0", "R"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ?", "PG-13","R") #.order("title ASC")
			session[:rating] = params[:ratings]
	# R	
	  elsif params[:ratings] == {"R"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? ", "R") #.order("title ASC")
			session[:rating] = params[:ratings]
	  elsif params[:sort_by] == "title"
	  	@movies = Movie.find(:all, :order => "title")
			@tit_class = 'hilite'
			session[:rating] = params[:ratings]
	  elsif params[:sort_by] == "release_date"
	  	@movies = Movie.find(:all, :order => "release_date")
			session[:rating] = params[:ratings]
			@rel_class = 'hilite'
	  else
	  	@movies = Movie.all
 		  @all_ratings = Movie.all_ratings
 		  @checked = true
	  end
	  @all_ratings = Movie.all_ratings

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
