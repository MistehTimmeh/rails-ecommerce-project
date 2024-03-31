class CreateOrderProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :order_products do |t|
      t.integer :product_quantity
      t.decimal :product_total_price

      t.timestamps
    end
  end
end
