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
              too_long: ->(_, err) { I18n.t('errors.too_long', count: err[:count]) },
              too_short: ->(_, err) { I18n.t('errors.too_short', count: err[:count]) }
            }
end
