# frozen_string_literal: true

class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_ancestry

  validates :content,
            presence: true,
            length: {
              minimum: 2,
              maximum: 3000,
              too_long: '%<count>s characters is the maximum allowed',
              too_short: '%<count>s characters is the minimum allowed'
            }
end
