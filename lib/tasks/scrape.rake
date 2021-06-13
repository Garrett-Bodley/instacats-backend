require 'pic_parser'

namespace :scrape do
  desc "Scrape all cats from imgur index"

  task cats_new_index: :environment do
    include PicParser

    INDEX_URL = 'https://imgur.com/r/cats/new/page/'
    page_num = 0

    while page_num < 5

      html = HTTParty.get(INDEX_URL + "#{page_num}")
      doc = Nokogiri::HTML(html.body)
      posts = doc.css('div.post')
      
      posts.each do |post|
        parsed = parse_data(post)
        CatPic.exists?(parsed) ? CatPic.update(parsed) : CatPic.create(parsed)
      end

      page_num += 1
    end
  end

end
