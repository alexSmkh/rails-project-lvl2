# frozen_string_literal: true

class Posts::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment was successfully created.'
    else
      error_messages = @comment.errors.full_messages.map { |msg| "<li>#{msg}</li>" }.join
      alert_content = "<ul>#{error_messages}</ul>"
      redirect_to post_path(@post), alert: alert_content
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@comment.post), notice: 'Comment was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    post_id = @comment.post_id
    @comment.destroy
    redirect_to post_path(post_id)
  end

  private

  def set_comment
    @comment = PostComment.find(params[:id])
  end

  def comment_params
    params.require(:post_comment).permit(:content, :post_id, :parent_id)
  end
end
