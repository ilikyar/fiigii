class CreateTableJoinforliker < ActiveRecord::Migration
  def change
  	create_table :joinforliker do |t|
  		t.integer :liker_id
  		t.integer :status_id
  	end
  	add_index :joinforliker, :liker_id
  	add_index :joinforliker, :status_id
  	add_index :joinforliker, [:liker_id, :status_id], unique: true

  	create_table :joinforheater do |t|
  		t.integer :hater_id
  		t.integer :status_id
  	end
  	add_index :joinforheater, :hater_id
  	add_index :joinforheater, :status_id
  	add_index :joinforheater, [:hater_id, :status_id], unique: true
  end
end
