# frozen_string_literal: true

class Posts::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    return if current_user.likes.find_by(post_id: @post.id)

    @like = @post.likes.build(user: current_user)

    if @like.save
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path,
                    alert: @like.errors.full_messages
    end
  end

  def destroy
    @like = current_user.likes.find_by(id: params[:id], post_id: params[:post_id])

    return if @like.nil?

    @like.destroy
    redirect_back fallback_location: root_path
  end
end
