class AddDefaultValueToPostLikeCount < ActiveRecord::Migration[6.1]
  def change
    change_column_default :posts, :post_likes_count, 0
  end
end
