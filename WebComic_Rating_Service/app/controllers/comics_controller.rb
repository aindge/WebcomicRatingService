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
    if current_user.check_has_rated?(@comic.id)	
	respond_to do |format|
	    format.html { redirect_to '/', alert: "Error: You've already rated #{@comic.name}."}
	end
    end	

    ratingsHash = params[:ratings]
    	
    rates = check_for_num(@comic.rates) + 1
    artVal = check_for_num(@comic.rating_art)
    storyVal = check_for_num(@comic.rating_story)
    overallVal = check_for_num(@comic.rating_overall)

    #recalculate the new ratings using the new values
    art = ((artVal * (rates - 1)) + ratingsHash[:rating_art].to_i) / rates
    story = ((storyVal * (rates - 1)) + ratingsHash[:rating_story].to_i) / rates
    overall = ((overallVal * (rates - 1)) + ratingsHash[:rating_overall].to_i) / rates
	
    @comic.update(:rates => rates, :rating_art => art, :rating_story => story, :rating_overall => overall)
    current_user.record_rating(@comic.id)			
    respond_to do |format|    
	format.html { redirect_to '/', notice: "#{@comic.name} rated"}
    end
  end

  #check if a database number has been added
  helper_method :check_for_num
  def check_for_num(value)
    if value.nil?
	return 0
    else
	return value
    end
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
    
    @comic = Comic.new(comic_params)
    name = @comic.name
    url = @comic.url
    validation = {:name => name, :url => url}
    error = validate(validation)
   
    respond_to do |format|
	if Comic.pluck(:name).include? name
	    format.html { redirect_to '/comics/new', alert: "Error: Comic \"#{name}\" Already Exists"} 
        end

	if error != ""
              format.html { redirect_to '/comics/new', alert: "#{error}"}
        end
	   
        if @comic.save
          format.html { redirect_to @comic, notice: "Comic \"#{name}\" was successfully created." }
          format.json { render :show, status: :created, location: @comic }
        else
          format.html { render :new }
          format.json { render json: @comic.errors, status: :unprocessable_entity }
        end
    end
  end

  # PATCH/PUT /comics/1
  # PATCH/PUT /comics/1.json
  def update
    error = validate(comic_params)
    respond_to do |format|
	if error != ""
          format.html { redirect_to edit_comic_path(@comic), alert: "#{error}"}
        end

	if @comic.update(comic_params)
          format.html { redirect_to @comic, notice: "Comic \"#{@comic.name}\" was successfully changed." }
          format.json { render :show, status: :ok, location: @comic }
        else
          format.html { render edit_comic_path(@comic) }
          format.json { render json: @comic.errors, status: :unprocessable_entity }
        end
    end
  end

  helper_method :validate
  def validate(validation)
	result = ""
	url = validation[:url]
	if /http:\/\/..*[.]..*/.match url or /..*[.]..*/.match url
	   #do nothing - I don't know how to make this return for not match so I put the if nothing else something
	   #the logic should be: if notmatch(/http:\/\/..*[.]..*/) and notmatch(/..*[.]..*/)
	   #that's pseudo code but you get the idea
  	else 
	 result = "Invalid URL. Example: http://www.example.com"
        end 
	
	if validation[:name].empty? 
          result = "Required: Comic Name"
        end

	return result
  end


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
