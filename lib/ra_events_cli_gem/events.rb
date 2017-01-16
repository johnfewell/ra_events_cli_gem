# Scrape events from ra for the given city
# events have: title, venue, date, attending number, price, sale close date, line-up, desc

require 'pry'

class RAEventsCliGem::Events

  @@all = []
  

  def self.new_event(e)
    self.new("https://www.residentadvisor.net/#{e.css("a").attribute("href").text}")
  end

  def initialize(url=nil)
    @url = url
    @@all << self  
  end

  def self.all
    #returns all events in a given city
    @@all
  end


end
