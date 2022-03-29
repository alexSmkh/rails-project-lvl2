# frozen_string_literal: true

class PostCommentPolicy < ApplicationPolicy
  def create?
    user
  end

  def update?
    user&.id == record.user.id
  end

  def destroy?
    user&.id == record.user.id
  end
end
