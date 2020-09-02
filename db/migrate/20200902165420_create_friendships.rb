class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :friend_requested_id
      t.integer :friend_requestor_id
      t.boolean :accepted


      t.timestamps
    end
  end
end
