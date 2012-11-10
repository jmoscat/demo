class CreateUserClientJoins < ActiveRecord::Migration
  def change
    create_table :user_client_joins, :options => "DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci", :force => true do |t|
      t.string 		:user_id, :null => false
      t.string		:client_id, :null => false
      t.integer		:visits
      t.timestamps
    end
  end
end
