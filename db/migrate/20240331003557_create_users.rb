class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.text :username
      t.text :password
      t.boolean :is_admin
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
