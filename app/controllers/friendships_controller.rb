class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friendship = current_user.friendships.build
    @friendship.friend_id = params[:user_id]
    if !find(@friendship)
      @friendship.save
      redirect_to users_path, notice: 'Invite was successfully sent.'
    else
      redirect_to users_path, notice: 'The friendship already exist.'
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.accepted = true

    if @friendship.save
      redirect_to users_path, notice: 'Friend request was accepted.'
    else
      redirect_to users_path, alert: "Couldn't accept friend request."
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship.destroy
      redirect_to users_path, notice: 'Friendship was rejected.'
    else
      redirect_to users_path, alert: 'Error rejecting friendship.'
    end
  end

  def find(friendship)
    Friendship.where("user_id = ? AND friend_id = ?", friendship.user_id, friendship.friend_id).or(Friendship.where("user_id = ? AND friend_id = ?", friendship.friend_id, friendship.user_id)).exists?
  end
  
end
