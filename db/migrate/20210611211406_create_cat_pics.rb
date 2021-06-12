class CreateCatPics < ActiveRecord::Migration[6.1]
  def change
    create_table :cat_pics do |t|
      t.string :description
      t.string :thumbnail
      t.string :source
      t.integer :viewcount
      t.boolean :animated
      t.datetime :posted_at

      t.timestamps
    end
  end
end
