class LikesController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def create
    @post = Post.find(params[:post_id])
    # current_user.like.create(post_id: params[:post_id])
    Like.create(user_id: current_user.id, post_id: params[:post_id])
    UserMailer.with(user_from: current_user, user_to: @post.user, post: @post).like_post.deliver_later if current_user.like(@post)
  end

  def destroy
    @post = Like.find(params[:id]).post
    # current_user.like.find(params[:post_id]).destroy
    Like.find(params[:id]).destroy
  end

  def like_posts
    @posts = current_user.like_posts.includes(:user).page(params[:page]).order(created_at: :desc).per(10)
  end
end
