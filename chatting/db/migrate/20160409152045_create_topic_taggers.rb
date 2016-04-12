class CreateTopicTaggers < ActiveRecord::Migration
  def change
    create_table :topic_taggers do |t|

      t.integer :topic_id
      t.integer :tag_id

      t.timestamps null: false
    end

    add_index :topic_taggers, :topic_id
    add_index :topic_taggers, :tag_id
  end
end
