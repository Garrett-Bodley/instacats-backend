class CreateCatPics < ActiveRecord::Migration[6.1]
  def change
    create_table :cat_pics do |t|
      t.string :imgur_id
      t.string :description
      t.integer :viewcount
      t.boolean :animated
      t.datetime :posted_at
      t.belongs_to :user

      t.timestamps
    end
  end
end
