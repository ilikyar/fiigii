class StatusesTopics < ActiveRecord::Migration
  def change
  	create_table :statuses_topics, :id => false do |t|
  		t.integer :status_id
  		t.integer :topic_id
  	end
  end
end
