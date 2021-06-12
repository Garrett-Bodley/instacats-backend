namespace :scrape do
  desc "Scrape all cats from imgur index"

  task cats_index: :environment do
   
    INDEX_URL = 'https://imgur.com/r/cats/new/page/'
    page_num = 1

    while page_num < 6

      html = HTTParty.get(INDEX_URL + "#{page_num}")
      doc = Nokogiri::HTML(html.body)
      posts = doc.css('div.post')
      
      posts.each do |post|
        binding.pry
        CatPic.new(parse_data(post))
      end

      page_num += 1
    end
  end

  def parse_data(post)
    data = Hash.new
    data[:imgur_id] = post.attributes['id'].value
    data[:description] = post.css('div.hover p')[0].content

    info = post.css('div.post-info')[0].content
    data[:viewcount] = parse_viewcount(info)
    data[:animated] = info.include?('animated')

    return data
  end

  def parse_viewcount(string)
    string.strip[/(\d*\,\d*\,\d*)/].delete(',').to_i
  end

end
