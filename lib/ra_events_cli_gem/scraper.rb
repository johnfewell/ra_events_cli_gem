require 'pry'

class RaEventsCliGem::Scraper
  attr_accessor :city, :year, :month, :day
  #I know this is confusing, this is the URL parameters for each city and their
  #index number from the first menu
  @@cities = {13 => 1, 34 => 2, 44 => 3, 60 => 4, 8 => 5, 29 => 6, 27 => 7, 25 => 8, 20 => 9, 15 => 10}

  def get_page
    url = "https://www.residentadvisor.net/events.aspx?ai=" + @@cities.key(@city).to_s + "&v=day&mn=" + @month + "&yr=" + @year + "&dy=" + @day
    Nokogiri::HTML(open(url))
  end

  def scrape_events
    self.get_page.css("div#event-listing li h1")
  end

  def make_events(city, year, month, day)
    @city = city
    @year = year
    @month = month
    @day = day
    scrape_events.each do |e|
      RaEventsCliGem::Events.new_event(e)
    end
  end

end
