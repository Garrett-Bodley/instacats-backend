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
      unless posts.count == 0
        posts.each do |post|
          parsed = parse_data(post)
          if pic = CatPic.find_by_imgur_id(parsed[:imgur_id])
            pic.update(parsed)
            if pic.save
              print "\rUpdated pic ##{pic.id}                  " 
            else
              print "\rPic ##{pic.id} is up to date!"
            end
          else 
            print "\rCreating a new CatPic.                 " if CatPic.create(parsed)
          end
        end
        puts ""
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