# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:one)
    @category = post_categories(:one)
    sign_in @user
  end

  test 'should get index' do
    get posts_url
    assert_response :success
  end

  test 'should get new' do
    get new_post_path
    assert_response :success
  end

  test 'should create post' do
    assert_difference('Post.count') do
      post posts_url, params: {
        post: {
          body: Faker::Lorem.sentence,
          post_category_id: @category.id,
          title: Faker::Lorem.word,
          user_id: @user.id
        }
      }
    end

    assert_redirected_to post_url(Post.last)
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end

  test 'should get edit' do
    get edit_post_url(@post)
    assert_response :success
  end

  test 'should update post' do
    patch post_url(@post), params: {
      post: {
        body: Faker::Lorem.sentence,
        post_category_id: @category.id,
        title: Faker::Lorem.word,
        user_id: @user.id
      }
    }
    assert_redirected_to post_url(@post)
  end

  test 'should destroy post' do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
