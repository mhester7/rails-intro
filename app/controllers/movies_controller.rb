class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    #rating = params[:rating]
    #@all_ratings = Rating.find(rating)
  end

  def index
  
  logger.debug(session[:session_id])
  #G
	  if params[:ratings] == {"G"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.find(:all, :conditions => {rating: "G"})#Movie.all
			session[:set_rate] = "G"
	  	@rate = session[:set_rate]
	  	@checked = true
	  	logger.debug(session[:set_rate])
	#G, PG  	
	  elsif params[:ratings] == {"G"=>"0", "PG"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ?", "G","PG") #.order("title ASC")
	  	@checked = true
	#G, PG, PG-13
	  elsif params[:ratings] == {"G"=>"0", "PG"=>"0", "PG-13"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ? OR rating = ?", "G","PG","PG-13") #.order("title ASC")
	  	@checked = true
	#G, PG, PG-13, R
	  elsif params[:ratings] == {"G"=>"0", "PG"=>"0", "PG-13"=>"0", "R"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ? OR rating = ? OR rating = ?", "G","PG","PG-13","R") #.order("title ASC")
	  	@checked = true
	#G, PG-13
	  elsif params[:ratings] == {"G"=>"0", "PG-13"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ?", "G","PG-13") #.order("title ASC")
	  	@checked = true
	#G, R
	  elsif params[:ratings] == {"G"=>"0", "R"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ?", "G","R") #.order("title ASC")
	  	@checked = true
	#PG
	  elsif params[:ratings] == {"PG"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ?", "PG") #.order("title ASC")
	  	@checked = true
	#PG, PG-13
	  elsif params[:ratings] == {"PG"=>"0", "PG-13"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ?", "PG","PG-13") #.order("title ASC")
	  	@checked = true
	#PG, PG-13, R
	  elsif params[:ratings] == {"PG"=>"0", "PG-13"=>"0", "R"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ? OR rating = ?", "PG","PG-13", "R") #.order("title ASC")
	  	@checked = true
	#PG, R
	  elsif params[:ratings] == {"PG"=>"0", "R"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ?", "PG","R") #.order("title ASC")
	  	@checked = true
	#PG-13
	  elsif params[:ratings] == {"PG-13"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ?", "PG-13") #.order("title ASC")
	  	@checked = true
	#PG-13, R	
	  elsif params[:ratings] == {"PG-13"=>"0", "R"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? OR rating = ?", "PG-13","R") #.order("title ASC")
	  	@checked = true
	# R	
	  elsif params[:ratings] == {"R"=>"0"} && params[:commit] == "Refresh"
	  	@movies = Movie.where("rating = ? ", "R") #.order("title ASC")
	  	@checked = true
	  elsif params[:sort_by] == "title"
	  	@movies = Movie.find(:all, :order => "title")
			@tit_class = 'hilite'
			#@title_header = 'title_header'
	  elsif params[:sort_by] == "release_date"
	  	@movies = Movie.find(:all, :order => "release_date")
			#@header = 'release_date_header'
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
