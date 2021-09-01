class CatPicSerializer < ActiveModel::Serializer
  attributes :id, :imgur_id, :src_url, :description, :viewcount, :animated, :posted_at, :user, :likes


  def likes
    if object.likes.count > 0
      response = {
        count: object.likes.count,
        likes: serialize_likes(object.likes)
      }
      return response
    else
      return nil
    end
  end

  def user
    object.user.username if !!object.user
  end

  private

  def serialize_likes(likes)
    serialized = []
    likes.each do |like|
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

end
