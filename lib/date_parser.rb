require 'pry-rails'

module DateParser

  def scrape(pics)
    config
    browser = Capybara.current_session
    driver = browser.driver.browser
    puts "Scraping #{pics.count} pics..."
    pics.each_with_index do |pic, index|
      print "\rParsing ##{index + 1}" 
      parse_date(pic, browser, driver)
    end
  end

  def config
    Capybara.register_driver :selenium do |app|  
      Capybara::Selenium::Driver.new(app, browser: :chrome, args: ["--mute-audio"])
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
      time = browser.find('div.post-title-meta time')
      post_datetime = DateTime.parse(time[:title])
      pic.posted_at = post_datetime
      pic.save
    rescue => e
      browser.visit(pic.src_url)
      wait_to_load(driver)
      if browser.current_url == "https://i.imgur.com/removed.png"
        puts "\nDestroying Pic ##{pic.id}"
        pic.destroy
      end
    end
  end

  def check_if_removed(pics)
    config
    browser = Capybara.current_session
    driver = browser.driver.browser
    puts "Scraping #{pics.count} pics..."
    pics.each_with_index do |pic, index|
      print "\rChecking ##{index + 1}" 
      browser.visit(pic.src_url)
      wait_to_load(driver)
      if browser.current_url == "https://i.imgur.com/removed.png"
        puts "\nDestroying Pic ##{pic.id}"
        pic.destroy
      end
    end
  end

end