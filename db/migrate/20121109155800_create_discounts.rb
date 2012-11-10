class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
    	t.string 		:hash
    	t.string		:user_id, :null => false #foreing key to user model
    	t.string    :client_id  #foreing key to client model
    	t.text 			:description
    	t.boolean 	:used
      t.timestamps
    end
  	add_index :hash
  end

end
