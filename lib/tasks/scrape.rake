require 'pic_parser'

namespace :scrape do
  desc "Scrape image info from imgur"

  task cats_new: :environment do
    desc "Scrape cat pics sorted by new"
    include PicParser
    NEW_URL = 'https://imgur.com/r/cats/new'
    PicParser.scrape(NEW_URL)
  end

  namespace :cats_top do
    TOP_URL = "https://imgur.com/r/cats/top"

    task all_time: :environment do
      desc "Scrape cat pics sorted by all time viewcount."
      include PicParser
      puts "scraping all time"
      PicParser.scrape_by_period(TOP_URL, 'all')
    end

    task year: :environment do
      desc "Scrape cat pics within the last year sorted by viewcount."
      include PicParser
      puts "scraping year"
      PicParser.scrape_by_period(TOP_URL, 'year')
    end
    
    task month: :environment do
      desc "Scrape cat pics within the last month sorted by viewcount."
      include PicParser
      puts "scraping month"
      PicParser.scrape_by_period(TOP_URL, 'month')
    end
    
    task week: :environment do
      desc "Scrape cat pics within the last week sorted by viewcount."
      include PicParser
      puts "scraping week"
      PicParser.scrape_by_period(TOP_URL, 'week')
    end
    
    task day: :environment do
      desc "Scrape cat pics uploaded today sorted by viewcount."
      include PicParser
      puts "scraping day"
      PicParser.scrape_by_period(TOP_URL, 'day')
    end

    task load_all: :environment do
      include PicParser
      ['day', 'week', 'month', 'year', 'all'].each{|period| Rake::Task["scrape:cats_top:#{period}"].execute}
      puts "Loading complete"
    end

  end


end
