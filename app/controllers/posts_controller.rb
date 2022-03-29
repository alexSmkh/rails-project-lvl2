# frozen_string_literal: true

class PostsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, except: %i[index show]

  def index
    @pagy, @posts = pagy(Post.order(created_at: :desc).includes(:creator))
  end

  def show
    @post = Post.includes(:creator).find(params[:id])
    @comments = @post.comments.includes(:user).arrange
    @comment = @post.comments.build
  end

  def new
    @post = current_user.posts.build
    authorize @post
  end

  def create
    @post = current_user.posts.build(post_params)
    authorize @post

    if @post.save
      redirect_to post_path(@post),
                  notice: I18n.t('notice.entity_created', entity: 'Post')
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    authorize @post

    if @post.update(post_params)
      redirect_to post_path(@post),
                  notice: I18n.t('notice.entity_updated', entity: 'Post')
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post

    @post.destroy
    redirect_to posts_path,
                notice: I18n.t('notice.entity_destroyed', entity: 'Post')
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_category_id)
  end
end
