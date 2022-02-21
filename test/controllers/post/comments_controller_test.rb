# frozen_string_literal: true

require 'test_helper'

class Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @post = posts(:one)
    @user = users(:one)
    @comment = post_comments(:two)
    sign_in @user
  end

  test 'should create comment' do
    assert_difference('@post.comments.count') do
      post post_comments_path(@post),
           params: {
             post_comment: {
               content: 'text'
             }
           }
    end

    assert_redirected_to post_path(@post)
  end

  test 'should create a reply to comment' do
    assert_difference('@comment.children.count') do
      post post_comments_path(@post),
           params: {
             post_comment: {
               content: 'text',
               parent_id: @comment.id
             }
           }
    end

    assert_redirected_to post_path(@post)
  end

  test 'should edit comment' do
    get edit_comment_path(@comment)

    assert_response :success
  end

  test 'should update comment' do
    updated_content = 'updated text'
    patch comment_path(@comment), params: {
      post_comment: {
        content: updated_content
      }
    }

    assert_redirected_to post_path(@comment.post)

    @comment.reload

    assert { @comment.content == updated_content }
  end

  test 'should destroy comment' do
    post = @comment.post
    assert_difference('@post.comments.count', -1) do
      delete comment_path(@comment)
    end

    assert_redirected_to post_path(post)
  end

  test 'should destroy the child comments along with the parent comment' do
    comment_with_children = post_comments(:one)
    post = comment_with_children.post
    assert_difference('@post.comments.count', -2) do
      delete comment_path(comment_with_children)
    end

    assert_redirected_to post_path(post)
  end
end
