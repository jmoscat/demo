class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits, :options => "DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci", :force => true do |t|
    	t.string		:user_id, :null => false #foreing key to user model
    	t.string    :client_id, :null => false   #foreing key to client model
    	t.float			:price
      t.timestamps
    end
  end
end
