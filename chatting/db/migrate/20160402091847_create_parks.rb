class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|

      t.integer :raw_id
      t.string :name
      t.string :place
      t.string :style
      t.string :story

      t.timestamps null: false
    end
  end
end
