class PostCategory < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30, minimum: 2 }
  has_many :posts
end
