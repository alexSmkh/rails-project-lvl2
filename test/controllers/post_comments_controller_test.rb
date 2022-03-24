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
    content = Faker::Lorem.sentence
    assert_difference('@post.comments.count') do
      post post_comments_path(@post),
           params: {
             post_comment: {
               content: content
             }
           }
    end

    new_comment = PostComment.find_by(
      content: content,
      user: @user,
      post: @post
    )

    assert { new_comment }
    assert_redirected_to post_path(@post)
  end

  test 'should create a reply to comment' do
    content = Faker::Lorem.sentence
    assert_difference('@comment.children.count') do
      post post_comments_path(@post),
           params: {
             post_comment: {
               content: content,
               parent_id: @comment.id
             }
           }
    end

    new_comment = PostComment.find_by(
      ancestry: @comment,
      content: content,
      user: @user,
      post: @post
    )

    assert { new_comment }
    assert_redirected_to post_path(@post)
  end

  test 'should edit comment' do
    get edit_comment_path(@comment)

    assert_response :success
  end

  test 'should update comment' do
    updated_content = Faker::Lorem.sentence
    patch comment_path(@comment), params: {
      post_comment: {
        content: updated_content
      }
    }

    assert_redirected_to post_path(@post)

    @comment.reload

    assert { @comment.content == updated_content }
  end

  test 'should destroy comment' do
    assert_difference('@post.comments.count', -1) do
      delete comment_path(@comment)
    end

    assert_raises ActiveRecord::RecordNotFound do
      PostComment.find(@comment.id)
    end

    assert_redirected_to post_path(@post)
  end

  test 'should destroy the child comments along with the parent comment' do
    comment_with_child = post_comments(:parent)
    comment_child = post_comments(:three)
    post_id = comment_with_child.post.id
    assert_difference('@post.comments.count', -2) do
      delete comment_path(comment_with_child)
    end

    assert_raises ActiveRecord::RecordNotFound do
      PostComment.find(comment_with_child.id)
    end

    assert_raises ActiveRecord::RecordNotFound do
      PostComment.find(comment_child.id)
    end

    assert_redirected_to post_path(post_id)
  end
end
