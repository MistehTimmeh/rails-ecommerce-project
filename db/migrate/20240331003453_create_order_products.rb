class CreateOrderProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :order_products, primary_key: [:product_id, :order_id] do |t|
      t.integer :product_quantity
      t.decimal :product_total_price
      t.references :product, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
