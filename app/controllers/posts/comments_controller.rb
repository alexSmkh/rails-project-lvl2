# frozen_string_literal: true

class Posts::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[edit update destroy]
  before_action :require_permission, only: %i[edit update destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: I18n.t('notice.entity_created', entity: 'Comment')
    else
      redirect_to post_path(@post),
                  alert: @comment.errors.full_messages
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@comment.post), notice: I18n.t('notice.entity_updated', entity: 'Comment')
    else
      render :edit
    end
  end

  def destroy
    post_id = @comment.post_id
    @comment.destroy
    redirect_to post_path(post_id), notice: I18n.t('notice.entity_destroyed', entity: 'Comment')
  end

  private

  def set_comment
    @comment = PostComment.find(params[:id])
  end

  def require_permission
    return if @comment.user == current_user

    redirect_back fallback_location: post_path(@comment.post), alert: I18n.t('errors.permission')
  end

  def comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
