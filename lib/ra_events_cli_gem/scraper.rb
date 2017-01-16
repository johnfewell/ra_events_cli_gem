require 'pry'

class RAEventsCliGem::Scraper
  attr_accessor :city, :year, :month, :day
  @@cities = {13 => 1, 34 => 2, 44 => 3, 60 => 4, 8 => 5, 29 => 6, 27 => 7, 24 => 8, 20 => 9, 15 => 10}

  def get_page
    url = "https://www.residentadvisor.net/events.aspx?ai=" + @@cities.key(@city).to_s + "&v=day&mn=" + @month + "&yr=" + @year + "&dy=" + @day 
    Nokogiri::HTML(open(url))
  end 

  def scrape_events
    self.get_page.css("div#event-listing li")
  end

  def make_events(city, year, month, day)
    @city = city
    @year = year
    @month = month
    @day = day
    scrape_events.each do |e| 
      RAEventsCliGem::Events.new_event(e)
    end  
    binding.pry
  end

end
