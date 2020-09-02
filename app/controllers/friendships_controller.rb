class FriendshipsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @friendship = current_user.friendships.build
      @friendship.friend_id = params[:user_id]
  
      if @friendship.save
        redirect_to users_path, notice: 'Invite was successfully sent.'
      else
        redirect_to users_path, alert: 'Invite was not sent.'
      end
    end
  
  end
  