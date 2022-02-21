# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :category, class_name: 'PostCategory', foreign_key: 'post_category_id'
  has_many :comments, class_name: 'PostComment', dependent: :destroy
  has_many :likes, class_name: 'PostLike', dependent: :destroy

  validates :title, presence: true, length: { minimum: 3, maximum: 30 }
  validates :body, presence: true, length: { minumum: 30, maximum: 20_000 }
end
