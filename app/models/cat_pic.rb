class CatPic < ApplicationRecord
  validates :imgur_id, uniqueness: true
  belongs_to :post
  scope :order_by_new, -> { order(posted_at: :desc) }

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
