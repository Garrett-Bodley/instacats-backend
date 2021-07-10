class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes, as: :likeable
  has_one :cat_pic

  def self.get_random
    Post.order(Arel.sql('RANDOM()')).limit(1)[0]
  end

end
