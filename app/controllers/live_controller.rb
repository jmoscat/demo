class LiveController < ApplicationController
  def get_live_tweets
    tweet = User.order("created_at DESC").first
    respond_to do |format|
      format.js { render :json => tweet}
  	end
end
