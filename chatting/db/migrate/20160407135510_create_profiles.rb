class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.integer :user_id
      t.text :about

      t.timestamps null: false
    end

    add_column :users, :profile_id, :integer
  end
end
