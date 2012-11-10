class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets, :options => "DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci", :force => true do |t|
    	t.string   :tweet_id, :null => false
    	t.string   :twitter_user_id
    	t.text     :tweet_text
    	t.string   :place
      t.timestamps
    end
  end
end
