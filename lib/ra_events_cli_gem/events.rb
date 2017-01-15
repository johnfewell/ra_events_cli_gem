# Scrape events from ra for the given city
# events have: title, venue, date, attending number, price, sale close date, line-up, desc

require 'pry'
require 'date'

class RAEventsCliGem::Events

  attr_accessor :city, :year, :month, :day

  @@base_url = "https://www.residentadvisor.net/events.aspx?ai="
  #?ai=8&v=day&mn=1&yr=2017&dy=15
  @@cities = {1 => 13, 2 => 34, 3 => 44, 5 => 8, 4 => 60, 6 => 29, 7 => 27, 8 => 24, 9 => 20, 10 => 15}

  def initialize

  end

  def self.all
      #returns all events in a given city

    event_1 = self.new

  end

end
