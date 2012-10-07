class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, :options => "DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci", :force => true do |t|
    	t.string   :twitter_user_id
    	t.string   :tweet_id
    	t.string 	 :influence
      t.text     :tweet_text, :null => false
      t.string   :tweet_username, :null => false
      t.string   :tweet_image_link
      t.string   :tweet_user_link
      t.float    :tweet_user_average_tweets_day
      t.integer  :tweet_user_number_followers
      t.integer  :tweet_user_number_following
      t.string   :tweet_location
      t.float    :ratio
      t.boolean  :profile_null
      t.integer  :listed_count
      t.integer  :retweet_count, :default => 0
      t.string   :geo_location
      t.boolean  :ratio
      t.boolean  :verified
      t.timestamps
    end
    add_index :users, :twitter_user_id, :unique => true
  end
end
