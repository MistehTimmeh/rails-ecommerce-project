class CreateFlowerTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :flower_types do |t|
      t.string :type_name

      t.timestamps
    end
  end
end
