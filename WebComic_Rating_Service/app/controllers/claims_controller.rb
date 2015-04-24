class ClaimsController < ApplicationController
	before_action :set_claim, only: [:destroy]
	
	def index
		if !User.is_admin?(current_user)
			respond_to do |format|
				format.html { redirect_to '/', alert: "You do not have permission to do this." }
			end
			return
		end
		@claims = Claim.order("created_at DESC")
	end

	def destroy
		if !User.is_admin?(current_user)
			respond_to do |format|
				format.html { redirect_to '/', alert: "You do not have permission to do this." }
			end
			return
		end
		@claim.destroy!
		respond_to do |format|
      format.html { redirect_to claims_path, notice: "The claim was successfully rejected." }
    end
	end
	
	def new
		@claim = Claim.new
	end

	def create
		@claim = Claim.new(claim_params)
		begin
			@claim.save!
		rescue
			respond_to do |format|
				format.html { redirect_to "/claims/new?comic_id=#{@claim.comic_id}", alert: "The Information field can't be blank." }
			end
			return
		end
		respond_to do |format|
		format.html { redirect_to "/comics/#{@claim.comic_id}", notice: "Your claim has been successfully filed and is awaiting moderator approval." }
		end
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim
      @claim = Claim.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_params
      params.require(:claim).permit(:comic_id, :user_id, :body)
    end
end
