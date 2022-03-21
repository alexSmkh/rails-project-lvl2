# frozen_string_literal: true

class PostComment < ApplicationRecord
  has_ancestry

  belongs_to :user
  belongs_to :post, counter_cache: true

  validates :content,
            presence: true,
            length: { minimum: 2, maximum: 3000 }
end
