# frozen_string_literal: true

class PostLikePolicy < ApplicationPolicy
  def create?
    user
  end

  def destroy?
    user&.id == record.user.id
  end
end
