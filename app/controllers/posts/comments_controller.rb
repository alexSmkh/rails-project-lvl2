# frozen_string_literal: true

class Posts::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    authorize @comment

    if @comment.save
      redirect_to post_path(@post), notice: I18n.t('notice.entity_created', entity: 'Comment')
    else
      redirect_to post_path(@post),
                  alert: @comment.errors.full_messages
    end
  end

  def edit
    @comment = PostComment.find(params[:id])
    authorize @comment
  end

  def update
    @comment = PostComment.find(params[:id])
    authorize @comment

    if @comment.update(comment_params)
      redirect_to post_path(@comment.post), notice: I18n.t('notice.entity_updated', entity: 'Comment')
    else
      render :edit
    end
  end

  def destroy
    @comment = PostComment.find(params[:id])
    authorize @comment

    post_id = @comment.post_id
    @comment.destroy
    redirect_to post_path(post_id), notice: I18n.t('notice.entity_destroyed', entity: 'Comment')
  end

  private

  def comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
