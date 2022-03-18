# frozen_string_literal: true

class Posts::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    return if current_user.likes.where(post_id: @post.id).first

    @like = @post.likes.build(user: current_user)

    if @like.save
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path, alert: I18n.t('errors.something_was_wrong')
    end
  end

  def destroy
    @like = current_user.likes.where(id: params[:id], post_id: params[:post_id]).first

    return if @like.nil?

    @like.destroy
    redirect_back fallback_location: root_path
  end
end
