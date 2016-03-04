class AddImagesToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :images, :text, array:true, default: []
  end
end
