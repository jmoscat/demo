Demo::Application.routes.draw do
  scope :path => '/live', :controller => :live do
    match 'index' => :index
    match 'results' => :results
    match 'get_live_tweets' => :get_live_tweets
  end

  root :to => 'live#index'
end
