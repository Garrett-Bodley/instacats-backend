class CatPicSerializer < ActiveModel::Serializer
  attributes :id, :imgur_id, :description, :viewcount, :animated, :posted_at
end
