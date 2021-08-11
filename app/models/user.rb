class User < ApplicationRecord
  has_secure_password
  has_many :cat_pics
  has_many :comments
  has_many :likes

  def self.get_random
    User.order(Arel.sql('RANDOM()')).limit(1)[0]
  end
end
