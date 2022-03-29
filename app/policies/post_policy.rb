# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def create?
    user
  end

  def update?
    user&.id == record.creator.id
  end

  def destroy?
    user&.id == record.creator.id
  end
end
