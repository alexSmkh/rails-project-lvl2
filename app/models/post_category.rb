# frozen_string_literal: true

class PostCategory < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30, minimum: 2 }
  has_many :posts, dependent: :nullify
end
