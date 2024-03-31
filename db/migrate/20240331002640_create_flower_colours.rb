class CreateFlowerColours < ActiveRecord::Migration[7.1]
  def change
    create_table :flower_colours do |t|
      t.string :colour_name

      t.timestamps
    end
  end
end
