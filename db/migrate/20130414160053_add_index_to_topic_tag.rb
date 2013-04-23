class AddIndexToTopicTag < ActiveRecord::Migration
  def change
  	add_index :topics, :tag, unique: true

  	add_index :statuses_topics, :status_id
  	add_index :statuses_topics, :topic_id
  	add_index :statuses_topics, [:status_id, :topic_id], unique: true
  end
end
