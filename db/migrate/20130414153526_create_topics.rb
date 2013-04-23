class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :tag

      t.timestamps
    end
  end
end
