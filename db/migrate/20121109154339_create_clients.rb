class CreateClients < ActiveRecord::Migration
  def change
    create_table :users, :options => "DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci", :force => true do |t|
      t.string		 :twitter_name, :null => false
      t.string     :twitter_user_id
      t.string     :email
      t.timestamps
    end
    add_index :twitter_name
  end
end
