class Comment < ApplicationRecord
  belongs_to :cat_pic
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy

  def self.get_random
    Comment.order(Arel.sql('RANDOM()')).limit(1)[0]
  end

end
