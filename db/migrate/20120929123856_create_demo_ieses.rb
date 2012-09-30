class CreateDemoIeses < ActiveRecord::Migration
  def change
    create_table :demo_ieses do |t|

      t.timestamps
    end
  end
end
