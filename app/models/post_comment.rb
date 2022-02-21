# frozen_string_literal: true

class PostComment < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id', inverse_of: 'comments'
  belongs_to :post

  has_ancestry
end
