class LiveController < ApplicationController
	def index
		@tweets = User.order("created_at DESC").limit(2)
	end


  def get_live_tweets
    tweet = User.order("created_at DESC").first
    respond_to do |format|
      format.js { render :json => tweet}
  	end
  end
end
