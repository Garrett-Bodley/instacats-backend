class CatPicSerializer < ActiveModel::Serializer
  attributes :id, :imgur_id, :src_url, :description, :viewcount, :animated, :posted_at
end
