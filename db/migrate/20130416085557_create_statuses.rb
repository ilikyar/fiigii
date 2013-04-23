class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.text :content
      t.integer :retweeted_id
      t.integer :user_id

      t.timestamps
    end
    add_index :statuses, :user_id
    add_index :statuses, :retweeted_id
    add_index :statuses, :created_at
  end
end
