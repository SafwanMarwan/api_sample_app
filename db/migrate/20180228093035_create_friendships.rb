class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|

      t.timestamps
    end
  end

  def change
    create_table :friendships do |t|
      t.integer :requestor_id, :null => false
      t.integer :receiver_id, :null => false

      t.timestamps null: false
    end

    add_index :friendships, :requestor_id
    add_index :friendships, :receiver_id
    add_index :friendships, [:requestor_id, :receiver_id], unique: true
  end
end
