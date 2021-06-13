module PicParser

  def scrape_by_period(url, period)
    scrape(url + "/#{period}")
  end

  def scrape(base_url)
    page_num = 0
    while page_num < 5
      html = HTTParty.get(base_url + "/page/#{page_num}")
      doc = Nokogiri::HTML(html.body)
      posts = doc.css('div.post:not(.empty)')
      
      posts.each do |post|
        parsed = parse_data(post)
        CatPic.exists?(parsed) ? CatPic.update(parsed) : CatPic.create(parsed)
      end

      page_num += 1
    end

  end

  def parse_data(post)
    data = Hash.new
    data[:imgur_id] = post.attributes['id'].value rescue return
    data[:description] = post.css('div.hover p')[0].content

    info = post.css('div.post-info')[0].content
    data[:viewcount] = parse_viewcount(info)
    data[:animated] = info.include?('animated')

    return data
  end

  def parse_viewcount(string)
    string.strip[/(\d*\,?\d*\,?\d+)|ø/].delete(',').to_i
  end

end