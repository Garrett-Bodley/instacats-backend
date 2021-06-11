class CreateCatPics < ActiveRecord::Migration[6.1]
  def change
    create_table :cat_pics do |t|
      t.string :title
      t.string :link

      t.timestamps
    end
  end
end
