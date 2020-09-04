class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    user_timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    @timeline_posts ||= Post.where(user_id: current_user.friends_and_i).ordered_by_most_recent.includes(:user)
  end

  def user_timeline_posts
    @timeline_posts ||= Post.where(user: current_user).or(Post.where(user: current_user.friends)).ordered_by_most_recent
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
