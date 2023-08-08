class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to request.referer
  end

  def follower_lists
    user = User.find(params[:user_id])
    @users = user.follower_lists
  end

  def followed_lists
    user = User.find(params[:user_id])
    @users = user.followed_lists
  end

end
