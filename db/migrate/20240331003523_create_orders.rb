class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.date :order_date
      t.decimal :order_price
      t.string :stripe_payment_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
