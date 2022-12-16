class CreateShips < ActiveRecord::Migration[6.1]
  def change
    create_table :ships do |t|

      t.string :address, null: false, default: ""
      t.string :post_code, null: false, default: ""
      t.string :name, null: false, default: ""
      
      t.timestamps
    end
  end
end
