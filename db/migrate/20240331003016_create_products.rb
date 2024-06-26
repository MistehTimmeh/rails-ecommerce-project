class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.integer :price_cents
      t.text :description
      t.references :flower_colour, null: false, foreign_key: true
      t.references :flower_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
