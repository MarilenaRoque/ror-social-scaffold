class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    # @users = User.all_except(current_user)
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def requests
    @requests = current_user.friend_requests
  end
end
