require 'pic_parser'
require 'date_parser'

namespace :scrape do

  desc "Scrape all possible cat pics."
  task cats_all: :environment do
    Rake::Task['scrape:cats_new'].execute
    Rake::Task['scrape:cats_top:load_all'].execute
  end

  desc "Scrape cat pics sorted by new."
  task cats_new: :environment do
    include PicParser
    puts "Scraping new cat pics."
    NEW_URL = 'https://imgur.com/r/cats/new'
    PicParser.scrape(NEW_URL)
  end

  desc "Scrape upload datetime of any CatPics in the database where posted_at == nil."
  task posted_at: :environment do
    include DateParser
    DateParser.scrape(CatPic.where(posted_at: nil))
    puts "\nPost dates scraped!"
  end

  namespace :cats_top do
    TOP_URL = "https://imgur.com/r/cats/top"

    desc "Scrape top cat pics sorted by all time viewcount."
    task all_time: :environment do
      include PicParser
      puts "Scraping top pics by all time."
      PicParser.scrape_by_period(TOP_URL, 'all')
    end

    desc "Scrape top cat pics within the last year sorted by viewcount."
    task year: :environment do
      include PicParser
      puts "Scraping top pics by year."
      PicParser.scrape_by_period(TOP_URL, 'year')
    end
    
    desc "Scrape top cat pics within the last month sorted by viewcount."
    task month: :environment do
      include PicParser
      puts "Scraping top pics by month."
      PicParser.scrape_by_period(TOP_URL, 'month')
    end
    
    desc "Scrape top cat pics within the last week sorted by viewcount."
    task week: :environment do
      include PicParser
      puts "Scraping top pics by week."
      PicParser.scrape_by_period(TOP_URL, 'week')
    end
    
    desc "Scrape top cat pics uploaded today sorted by viewcount."
    task day: :environment do
      include PicParser
      puts "Scraping top pics by day."
      PicParser.scrape_by_period(TOP_URL, 'day')
    end

    desc "Scrape top cat pics from every possible time period."
    task load_all: :environment do
      ['day', 'week', 'month', 'year', 'all_time'].each{|period| Rake::Task["scrape:cats_top:#{period}"].execute}
      puts "Loading complete"
    end

  end

end
