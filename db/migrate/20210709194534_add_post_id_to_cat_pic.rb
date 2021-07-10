class AddPostIdToCatPic < ActiveRecord::Migration[6.1]
  def change
    add_column :cat_pics, :post_id, :integer
  end
end
