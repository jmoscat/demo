class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts, :options => "DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci", :force => true do |t|
    	t.string 		:hash_key
    	t.string		:user_id, :null => false #foreing key to user model
    	t.string    :client_id  #foreing key to client model
    	t.text 			:description
    	t.boolean 	:used
      t.timestamps
    end
  	add_index :discounts, :hash_key
  end

end
