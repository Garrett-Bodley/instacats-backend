class CatPic < ApplicationRecord
  validates :imgur_id, uniqueness: true
end
