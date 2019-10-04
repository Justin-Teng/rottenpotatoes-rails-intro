class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if params.has_key? 'order_by'
      @order_by = params[:order_by]
    
    if @order_by
      # Sort list by column specified
      @movies = Movie.order("#{@order_by} asc")
    else
      # Just show the list
      @movies = Movie.all()
    end
    return
    
    # G, PG, PG-13, R
    @all_ratings = Movie.get_ratings
    
    # Get ratings hash from user selected ratings if specified, else load from session hash
    if params.has_key? 'ratings'
      @ratings = params[:ratings]
    else
      @ratings = session[:ratings]
    end

    # Get order_by hash from user selected order_by if specified, else load from session hash
    if params.has_key? 'order_by'
      @order_by = params[:order_by]
    else
      @order_by = session[:order_by]
    end
    
    #flash.keep
    #redirect_to movies_path({ratings: @ratings, order_by: @order_by})
    
    # Save settings to session hash
    session[:ratings]  = @ratings if @ratings
    session[:order_by] = @order_by if @order_by
    
    if @ratings
      # Show only movies with ratings specified
      if @order_by
        # Sort list by column specified
        @movies = Movie.where(rating: @ratings.keys).order('#{@order_by} ASC')
      else
        # Don't sort list
        @movies = Movie.where(rating: @ratings.keys)
      end
    elsif @order_by
      # Sort list by column specified
      @movies = Movie.order("#{@order_by} asc")
    else
      # Just show the list
      @movies = Movie.all()
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
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
