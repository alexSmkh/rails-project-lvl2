# frozen_string_literal: true

class PostsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[edit update destroy]
  before_action :require_permission, only: %i[edit update destroy]

  def index
    @pagy, @posts = pagy(Post.order(created_at: :desc).includes(:creator))
  end

  def show
    @post = Post.includes(comments: [:user]).find(params[:id])
    @comment = @post.comments.build
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post),
                  notice: I18n.t('notice.entity_created', entity: 'Post')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post),
                  notice: I18n.t('notice.entity_updated', entity: 'Post')
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path,
                notice: I18n.t('notice.entity_destroyed', entity: 'Post')
  end

  private

  def require_permission
    unless Post.find(params[:id]).creator == current_user
      redirect_back fallback_location: post_path(params[:id]),
                    alert: I18n.t('errors.permission')
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :post_category_id)
  end
end
