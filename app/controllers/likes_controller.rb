class LikesController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def create
    @post = Post.find(params[:post_id])
    #current_user.like.create(post_id: params[:post_id])
    Like.create(user_id: current_user.id, post_id: params[:post_id])
  end

  def destroy
    @post = Like.find(params[:id]).post
    #current_user.like.find(params[:post_id]).destroy
    Like.find(params[:id]).destroy
  end
end
