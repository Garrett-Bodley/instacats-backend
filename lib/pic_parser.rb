module PicParser

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
    string.strip[/(\d*\,?\d*\,?\d+)/].delete(',').to_i
  end

end