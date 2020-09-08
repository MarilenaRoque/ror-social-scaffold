class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friendship = current_user.friendships.build
    @friendship.friend_id = params[:user_id]
    # one individual relation is made, with status nil
    if @friendship.save
      redirect_to users_path, notice: 'Invite was successfully sent.'
    else
      redirect_to users_path, alert: 'Invite was not sent.'
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.accepted = true
    @inverse_friendship = Friendship.create(friend_id: @friendship.user_id,
                                            user_id: @friendship.friend_id,
                                            accepted: true)
    if @inverse_friendship.save && @friendship.save
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
end
