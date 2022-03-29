class AddDefaultValueToPostCommentCount < ActiveRecord::Migration[6.1]
  def change
    change_column_default :posts, :post_comments_count, 0
  end
end
