class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :status_id
      t.integer :reply_comment_id

      t.timestamps
    end
  end
end
