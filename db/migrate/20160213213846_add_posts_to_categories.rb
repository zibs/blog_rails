class AddPostsToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :post, index: true, foreign_key: true
  end
end
