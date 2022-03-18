# frozen_string_literal: true

class PostsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :require_permission, only: %i[edit update destroy]

  def index
    @pagy, @posts = pagy(Post.order(created_at: :desc))
  end

  def show
    @comment = PostComment.new
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post), notice: I18n.t('notice.entity_created', entity: 'Post')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: I18n.t('notice.entity_updated', entity: 'Post')
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: I18n.t('notice.entity_destroyed', entity: 'Post')
  end

  private

  def require_permission
    redirect_back fallback_location: post_path(params[:id]), alert: I18n.t('errors.permission') \
    unless Post.find(params[:id]).creator == current_user
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :post_category_id)
  end
end
