#controller class for the comics database
class ComicsController < ApplicationController
  before_action :set_comic, only: [:show, :edit, :update, :destroy]

  # GET /comics
  # GET /comics.json
  def index
    #debugger
    @comics = Comic.order(sort_column + " " + sort_direction)
    #@comics = Comic.all
  end

  # code i added to make it sort  also code in comics_helper.rb
  helper_method :sort_column, :sort_direction
  def sort_column
    Comic.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
 	end

  # GET /comics/1
  # GET /comics/1.json
  def show
  end

	def show_user
		#TODO link to comics/user/:id showing comics by user with id :id
		redirect_to root
	end

  #GET comics/rating
  def rate
    @comic = Comic.find(params[:id])
  end

  #PUT comics/rating
  def reviseRate
    @comic = Comic.find(params[:id])

    #prevent users from rating again
    if current_user.check_has_rated?(@comic)	
	respond_to do |format|
	    format.html { redirect_to '/', alert: "Error: You've already rated #{@comic.name}."}
	end
    end	

    updateComicRating(@comic)
    current_user.record_rating(@comic)			
    respond_to do |format|    
	format.html { redirect_to '/', notice: "#{@comic.name} rated"}
    end
  end

  def updateComicRating(comic)
    rates = comic.rates + 1
    comic.update(:rates => rates, :rating_art => artRating(comic), :rating_story => storyRating(comic), :rating_overall => overallRating(comic))
  end

  def artRating(comic)
    ratingsHash = params[:ratings]
    (comic.rating_art * comic.rates + ratingsHash[:rating_art].to_i) / (comic.rates + 1)
  end
  
  def storyRating(comic)
    ratingsHash = params[:ratings]
    (comic.rating_story * comic.rates + ratingsHash[:rating_story].to_i) / (comic.rates + 1)
  end

  def overallRating(comic)
    ratingsHash = params[:ratings]
    (comic.rating_overall * comic.rates + ratingsHash[:rating_overall].to_i) / (comic.rates + 1)
  end

  # GET /comics/new
  def new
    @comic = Comic.new
  end

  # GET /comics/1/edit
  def edit
  end

  # POST /comics
  # POST /comics.json
  def create
    #ok = true    
    
    @comic = Comic.new(comic_params)
    #@comic.url = @comic.check_and_fix_url
    #
      #if Comic.pluck(:name).include? @comic.name
      
      if comicExists?#(@comic)
        CU_ExistingComic(@comic)
				#format.html { redirect_to '/comics/new', alert: "Error: Comic \"#{@comic.name}\" Already Exists"} 
				#ok = false
      else
        createNonExistingComic(@comic)
      end
    #end
    #return
  end

  # PATCH/PUT /comics/1
  # PATCH/PUT /comics/1.json
  def update
    #@comic.url = @comic.check_and_fix_url
    if comicExists? #@comic
      CU_ExistingComic(@comic)
    else
      updateNonExistingComic(@comic)
    end
  end

  def CU_ExistingComic(comic)
    respond_to do |format|
      format.html { redirect_to '/comics/new', alert: "Error: Comic \"#{comic.name}\" Already Exists"}
    end
  end

  def createNonExistingComic(comic)
    respond_to do |format|
      begin 
        @comic.save!
        format.html { redirect_to comic, notice: "Comic \"#{comic.name}\" was successfully created." }
        format.json { render :show, status: :created, location: comic }
      rescue         
        format.html { render :new}
        format.json { render json: comic.errors, status: :unprocessable_entity }
      end
    end
  end

  def updateNonExistingComic(comic)
    respond_to do |format|
        begin
          comic.update_attributes!(comic_params)
          format.html { redirect_to @comic, notice: "Comic \"#{comic.name}\" was successfully changed." }
          format.json { render :show, status: :ok, location: comic }
        rescue
          format.html { redirect_to :back,  alert: "Can't edit: One or more fields were invalid."}
          format.json { render json: comic.errors, status: :unprocessable_entity }
        end
    end
    
  end

  def comicExists?()
      @comic.url = @comic.check_and_fix_url
      # hope ruby has short circuit logic
      (Comic.pluck(:name).include? @comic.name) && (params[:action] == "create" || Comic.where(:name => @comic.name).first.id != @comic.id)
  end

	#I left this in here just in case, but it shouldn't be called.  

  # DELETE /comics/1
  # DELETE /comics/1.json
  def destroy
    @comic.destroy
    respond_to do |format|
      format.html { redirect_to '/', notice: "Comic \"#{@comic.name}\" was successfully deleted." }
      format.json { head :no_content }
    end
  end

	# POST /comics/search
  def search
		@comics = Comic.search(params[:search], sort_column, sort_direction)
  end

	def admin
		if !user_signed_in?
			respond_to do |format|
				format.html { redirect_to new_user_session_path, alert: "You need to log in to perform this action." }
			end
			return
		elsif !User.is_admin?(current_user)
			respond_to do |format|
				format.html { redirect_to '/', alert: "You do not have permission to do this." }
			end
			return
		end
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comic
      @comic = Comic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comic_params
      params.require(:comic).permit(:name, :author, :url, :synopsis, :genre, :rating_art, :rating_story, :rating_overall, :update_schedule, :page_layout)
    end
end
