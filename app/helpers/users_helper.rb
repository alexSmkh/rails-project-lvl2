# frozen_string_literal: true

module UsersHelper
  def author_of(record)
    user_signed_in? && current_user.id == record.user_id
  end
end
