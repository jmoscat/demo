Demo::Application.routes.draw do
  scope :path => '/live', :controller => :live do
    match 'index' => :index
    match 'results' => :results
    match 'get_live_tweets' => :get_live_tweets
  end

	match '/discount/:hash_key' => 'discount#show'
	match '/check/:hash_key' => 'discount#check'
  match '/redeem/:hash_key' => 'discount#redeem'
  match	'/sucess' => 'discount#success'
  match	'/failed' => 'discount#failed'
  match	'/notfound' => 'discount#notfound'


  root :to => 'live#index'
end
