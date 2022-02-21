class Posts::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(like_params)
    @like.user = current_user

    respond_to do |format|
      if @like.save
        format.html { redirect_back fallback_location: root_path }
        format.json { render json: @like, status: :created, location: @like }
      else
        format.html { redirect_back fallback_location: root_path, alert: 'Something was wrong. Please, try again' }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @like = PostLike.find(params[:id])
    @like.destroy

    redirect_back fallback_location: root_path
  end

  private

  def like_params
    params.permit(:post_id)
  end
end
