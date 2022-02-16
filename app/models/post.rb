# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post_category

  validates :title, presence: true, length: { minimum: 3, maximum: 30 }
  validates :body, presence: true, length: { minumum: 30, maximum: 20_000 }
end
