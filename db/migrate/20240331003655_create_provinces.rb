class CreateProvinces < ActiveRecord::Migration[7.1]
  def change
    create_table :provinces do |t|
      t.string :province_name
      t.string :province_shortcode
      t.decimal :province_taxes

      t.timestamps
    end
  end
end
