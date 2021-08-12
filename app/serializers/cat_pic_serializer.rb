class CatPicSerializer < ActiveModel::Serializer
  attributes :id, :imgur_id, :src_url, :description, :viewcount, :animated, :posted_at, :user

  def user
    object.user.username if !!object.user
  end
end
