class AddIndexForFriendship < ActiveRecord::Migration[5.2]
  def change
    add_index :friendships, :friend_requested_id
    add_index :friendships, :friend_requestor_id
  end
end
