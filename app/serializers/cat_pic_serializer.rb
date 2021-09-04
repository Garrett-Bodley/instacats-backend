class CatPicSerializer < ActiveModel::Serializer
  attributes :id, :imgur_id, :src_url, :description, :viewcount, :animated, :posted_at, :user, :likes

  def likes
    serialized = []
    return serialized if object.likes.count == 0
    object.likes.each do |like|
      data = {
        id: like.id,
        user: {
          id: like.user.id,
          username: like.user.username
        },
        likeable_id: like.likeable_id
      }
      serialized << data
    end
    return serialized
  end

  def user
    if !!object.user
      serialized = {
        id: object.user.id,
        username: object.user.username
      }
      return serialized 
    end
  end

end
