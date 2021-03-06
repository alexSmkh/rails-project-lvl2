# frozen_string_literal: true

require 'test_helper'

class Posts::LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @post = posts(:one)
    @user_with_like = users(:one)
    @user_without_like = users(:two)
    @like = post_likes(:one)
  end

  test 'shoud create like' do
    sign_in @user_without_like
    start_request_page = post_url(@post)
    post post_likes_path(@post),
         params: {
           post_like: { post_id: @post.id }
         },
         headers: {
           HTTP_REFERER: start_request_page
         }

    new_like = PostLike.find_by(
      post: @post,
      user: @user_without_like
    )

    assert { new_like }
    assert_redirected_to start_request_page
  end

  test 'should destroy like' do
    sign_in @user_with_like
    start_request_page = post_url(@post)
    delete post_like_path(@post, @like), headers: { HTTP_REFERER: start_request_page }

    assert_not PostLike.find_by(id: @like.id)

    assert_redirected_to start_request_page
  end
end
