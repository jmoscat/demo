class LiveController < ApplicationController
	def index
		@tweets = User.last(2)
	end

	def results
		@influencer = User.order("influence DESC").limit(10)
	end
  def get_live_tweets
    tweet = User.last
    respond_to do |format|
      format.js { render :json => tweet }
  	end
  end
end
