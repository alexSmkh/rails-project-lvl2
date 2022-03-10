# frozen_string_literal: true

class Posts::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[create destroy]

  def create
    @like = @post.likes.build(like_params)
    @like.user = current_user

    if @like.save
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path, alert: 'Something was wrong. Please, try again'
    end
  end

  def destroy
    @like = PostLike.find(params[:id])
    @like.destroy

    redirect_back fallback_location: root_path
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def like_params
    params.permit(:post_id)
  end
end
