class CatPic < ApplicationRecord
  validates :imgur_id, uniqueness: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  
  scope :order_by_new, -> { order(posted_at: :desc) }
  scope :order_by_likes, -> { joins(:likes).group('cat_pics.id').order('COUNT(likes.likeable_id) DESC') }
  scope :order_by_most_commented, -> { joins(:comments).group('cat_pics.id').order('COUNT(comments.cat_pic_id) DESC') }

  def self.get_random
    CatPic.order(Arel.sql('RANDOM()')).limit(1)[0]
  end

  def src_url
    self.animated ? "https://www.imgur.com/#{self.imgur_id}.mp4" : "https://www.imgur.com/#{self.imgur_id}.jpeg"
  end

  def page_url
    "https://www.imgur.com/r/cats/#{self.imgur_id}"
  end
end
