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
    body = Faker::Lorem.sentence
    title = Faker::Lorem.characters(number: 10)
    post posts_url, params: {
      post: {
        body: body,
        post_category_id: @category.id,
        title: title,
        user_id: @user.id
      }
    }

    post = Post.find_by(
      title: title,
      body: body,
      creator: @user,
      post_category: @category
    )

    assert { post }
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
    body = Faker::Lorem.sentence
    title = Faker::Lorem.characters(number: 10)

    patch post_url(@post), params: {
      post: {
        body: body,
        post_category_id: @category.id,
        title: title,
        user_id: @user.id
      }
    }

    @post.reload

    assert { @post.body == body }
    assert { @post.title == title }
    assert_redirected_to post_url(@post)
  end

  test 'should destroy post' do
    delete post_url(@post)

    refute Post.find_by(id: @post.id)

    assert_redirected_to posts_url
  end
end
