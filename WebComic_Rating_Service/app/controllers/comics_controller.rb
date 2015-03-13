class ComicsController < ApplicationController
  before_action :set_comic, only: [:show, :edit, :update, :destroy]

  # GET /comics
  # GET /comics.json
  def index
    #debugger
    @comics = Comic.all
  end

  # GET /comics/1
  # GET /comics/1.json
  def show
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
    
    
    respond_to do |format|
	if Comic.pluck(:name).include? @comic.name
	    format.html { redirect_to '/comics/new', alert: "Error: Comic \"#{@comic.name}\" Already Exists"} 
        else
	if /http:\/\/..*[.]..*/.match @comic.url
	  if @comic.name.empty? 
              format.html { redirect_to '/comics/new', alert: "Required: Comic Name"}
          else 
              if @comic.save
                format.html { redirect_to @comic, notice: "Comic \"#{@comic.name}\" was successfully created." }
                format.json { render :show, status: :created, location: @comic }
              else
                format.html { render :new }
                format.json { render json: @comic.errors, status: :unprocessable_entity }
              end
          end
        else
          if @comic.name.empty? 
              format.html { redirect_to '/comics/new', alert: "Required: Comic Name"}
          else   
	  if /..*[.]..*/.match @comic.url
	      @comic.url = "http://" + @comic.url
	      if @comic.save
                format.html { redirect_to @comic, notice: "Comic \"#{@comic.name}\" was successfully created." }
                format.json { render :show, status: :created, location: @comic }
              else
                format.html { render :new }
                format.json { render json: @comic.errors, status: :unprocessable_entity }
              end
  	  else
	      format.html { redirect_to '/comics/new', alert: "Invalid URL. Example: http://www.example.com"}
          end 
	  end
        end
        end
    end
    
  end

  # PATCH/PUT /comics/1
  # PATCH/PUT /comics/1.json
  def update
    respond_to do |format|
	if /http:\/\/..*[.]..*/.match comic_params[:url]
	  if comic_params[:name].empty? 
              format.html { redirect_to edit_comic_path(@comic), alert: "Required: Comic Name"}
          else 
              if @comic.update(comic_params)
                format.html { redirect_to @comic, notice: "Comic \"#{@comic.name}\" was successfully changed." }
                format.json { render :show, status: :ok, location: @comic }
              else
                format.html { render edit_comic_path(@comic) }
                format.json { render json: @comic.errors, status: :unprocessable_entity }
              end
          end
        else
          if comic_params[:name].empty? 
              format.html { redirect_to edit_comic_path(@comic), alert: "Required: Comic Name"}
          else   
	  if /..*[.]..*/.match comic_params[:url]
	      @comic.url = "http://" + @comic.url
	      if @comic.update(comic_params)
                format.html { redirect_to @comic, notice: "Comic \"#{@comic.name}\" was successfully changed." }
                format.json { render :show, status: :ok, location: @comic }
              else
                format.html { render edit_comic_path(@comic) }
                format.json { render json: @comic.errors, status: :unprocessable_entity }
              end
  	  else
	      format.html { redirect_to edit_comic_path(@comic) , alert: "Invalid URL. Example: http://www.example.com"}
          end 
	  end
        end
    end
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
