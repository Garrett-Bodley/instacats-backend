require 'pry-rails'

module DateParser

  def scrape(pics)
    config
    browser = Capybara.current_session
    driver = browser.driver.browser
    puts "Scraping....."
    pics.each_with_index do |pic, index|
      print "\rParsing Pic ##{index + 1}" 
      parse_date(pic, browser, driver)
    end

  end

  def config
    Capybara.register_driver :selenium do |app|  
      Capybara::Selenium::Driver.new(app, browser: :chrome)
    end
    Capybara.javascript_driver = :chrome
    Capybara.configure do |config|  
      config.default_max_wait_time = 10 # seconds
      config.default_driver = :selenium_chrome_headless
    end
  end

  def wait_to_load(driver)
    loop do
      sleep(0.1)
      break if driver.execute_script('return document.readyState') == "complete"
    end
  end

  def parse_date(pic, browser, driver)

    browser.visit(pic.page_url)
    wait_to_load(driver)

    begin
      span = browser.find('div.post-title-meta span')
      post_datetime = DateTime.parse(span[:title])
      pic.posted_at = post_datetime
      pic.save
    rescue => e
      binding.pry
    end

  end

end