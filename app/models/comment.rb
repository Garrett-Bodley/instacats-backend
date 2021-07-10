class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :likes, as: :likeable

  def self.get_random
    Comment.order(Arel.sql('RANDOM()')).limit(1)[0]
  end

end
