class AddPostCommentsCountToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :post_comments_count, :integer
  end
end
