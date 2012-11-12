class DiscountController < ApplicationController

  # GET /discounts/1
  # GET /discounts/1.json
  def show
    @cupon = Discount.find(:first, :conditions => [ "hash_key = ?", params[:hash_key]])
    @redeem = "localhost:3000/redeem/"+@cupon.hash_key
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @redeem }
    end
  end
  def redeem
  	@cupon = Discount.find(:first, :conditions => [ "hash_key = ?", params[:hash_key]])
  	@client_password = Discount.where(:hash_key => params[:hash_key]).first.client.password
  end

  def check
  	hash_key = params[:hash]
  	passcode = params[:passcode]
  	cupon = Discount.find(:first, :conditions => [ "hash_key = ?", hash_key])
  	if cupon.nil?
  		redirect_to :action => "notfound"
  	elsif (passcode == cupon.client.password) && (cupon.used == false)
  		cupon.checked
  		redirect_to :action => "success"
  	elsif (passcode == cupon.client.password) && (cupon.used == true)
  		redirect_to :action => "failed"
  	elsif (passcode != cupon.client.password)
  		
  	end
  end

  def success
  end
  def failed
  end
  def notfound
  end

  def qr 
    @client_url = Client.find(:first, :conditions => [ "hash_id = ?", params[:hash]]).tweet_url
    redirect_to @client_url
  end


end
