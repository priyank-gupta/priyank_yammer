class CreateFollows < ActiveRecord::Migration
  def self.up
    create_table :follows do |t|
      t.integer :user_id, :null => false
      t.integer :follow, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :follows
  end
end
