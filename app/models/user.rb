class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  def self.get_random
    User.order(Arel.sql('RANDOM()')).limit(1)
  end
end
