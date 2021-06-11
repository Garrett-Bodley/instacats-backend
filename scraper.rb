require 'pry'
require 'nokogiri'
require 'HTTParty'

URL = 'https://imgur.com/r/cats/new/page/'

page_num = 1
html = HTTParty.get(URL + "#{page_num}")
doc = Nokogiri::HTML(html)
posts = doc.css('div.post')

posts.each do |post|

end

binding.pry

# require 'kimurai'

# class CatScraper < Kimurai::Base
#   @name = :cat_scraper
#   @start_urls = ['https://imgur.com/r/cats/new/page/']
#   @engine = :selenium_chrome

#   @@cats = []

#   def scrape_page
#     doc = browser.current_response
#     posts = doc.css('div.post')

#     posts.each do |post|
#       binding.pry
#     end


#   end

#   def parse(response, url:, data: {})
#     scrape_page
#   end

# end

# CatScraper.crawl!