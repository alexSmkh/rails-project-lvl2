# frozen_string_literal: true

class Post::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[create]
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.creator = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { redirect_to post_path(@post), alert: @comment.errors }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully updated' }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    post = @comment.post
    @comment.destroy
    redirect_to post_path(post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = PostComment.find(params[:id])
  end

  def comment_params
    params.require(:post_comment).permit(:content, :post_id, :ancestry, :parent_id)
  end
end
