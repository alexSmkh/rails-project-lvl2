# frozen_string_literal: true

require 'test_helper'

class Posts::LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @post = posts(:one)
    @user = users(:one)
    @like = post_likes(:one)
    sign_in @user
  end

  test 'shoud like create' do
    start_request_page = post_url(@post)
    assert_difference('@post.likes.count') do
      post post_likes_path(@post),
           params: {
             post_like: {
               post_id: @post.id
             }
           },
           headers: {
             HTTP_REFERER: start_request_page
           }
    end

    assert_redirected_to start_request_page
  end

  test 'should destroy like' do
    start_request_page = post_url(@post)
    assert_difference('@post.likes.count', -1) do
      delete like_path(@like), headers: { HTTP_REFERER: start_request_page }
    end

    assert_redirected_to start_request_page
  end
end
