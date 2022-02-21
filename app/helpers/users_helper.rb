# frozen_string_literal: true

module UsersHelper
  def author_of(record)
    user_signed_in? && current_user.id == record.user_id
  end

  def get_user_post_like(post)
    user_signed_in? ? current_user.likes.where(post_id: post.id).first : nil
  end
end
