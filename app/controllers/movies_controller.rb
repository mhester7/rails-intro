class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    #rating = params[:rating]
    #@all_ratings = Rating.find(rating)
  end

  def index
	  @all_ratings = Movie.all_ratings
	  
	  #rate = params[:ratings]
	  #logger.debug(rate)
	  #if rate["G"] == "1" #params[:commit] == "Refresh" #params[:ratings] = {"G" => "1"} # && params.key?("G")
	  	#@movies = Movie.where(:rating => 'G')
	  	#find(:all, :conditions => { :rating => ["G"]})
	  #end
	  
	  if params[:sort_by] == "title"
	  	@movies = Movie.find(:all, :order => "title")
			@tit_class = 'hilite'
			#@title_header = 'title_header'
	  elsif params[:sort_by] == "release_date"
	  	@movies = Movie.find(:all, :order => "release_date")
			#@header = 'release_date_header'
			@rel_class = 'hilite'
	  else
	  	@movies = Movie.all
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
