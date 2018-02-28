class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :following_id, :null => false
      t.integer :follower_id, :null => false

      t.timestamps null: false
    end

    add_index :relationships, :following_id
    add_index :relationships, :follower_id
    add_index :relationships, [:following_id, :follower_id], unique: true
  end
end
