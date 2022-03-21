class AddPostLikesCountToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :post_likes_count, :integer
  end
end
