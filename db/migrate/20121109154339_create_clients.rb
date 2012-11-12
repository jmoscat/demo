class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients, :options => "DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci", :force => true do |t|
      t.string		 :twitter_name, :null => false
      t.string     :twitter_user_id
      t.string     :email
      t.string     :tweet_url
      t.string 		 :password
      t.timestamps
    end
    add_index :clients, :twitter_name
  end
end
