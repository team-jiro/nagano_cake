class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.integer :customer_id, null: false, default: ""
      t.string :shipping_cost, null: false, default: ""
      t.string :shipping_address, null: false, default: ""
      t.string :shipping_postal_code, null: false, default: ""
      t.string :shipping_name, null: false, default: ""
      t.integer :payment_method, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.integer :billing_amount, null: false, default: ""
      t.timestamps
    end
  end
end
