class CatPic < ApplicationRecord
  validates :imgur_id, uniqueness: true
  belongs_to :user
  belongs_to :post
end
