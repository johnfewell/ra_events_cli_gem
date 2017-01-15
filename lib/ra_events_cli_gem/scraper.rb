require 'pry'
require 'date'

class RAEventsCliGem::Scraper
  attr_accessor :city, :year, :month, :day
  @@base_url = "https://www.residentadvisor.net/events.aspx?ai="
  #?ai=8&v=day&mn=1&yr=2017&dy=15
  @@cities = {13 => 1, 34 => 2, 44 => 3, 60 => 4, 8 => 5, 29 => 6, 27 => 7, 24 => 8, 20 => 9, 15 => 10}

  def get_page(city, year, month, day)
    url = @@base_url + @@cities.key(city) + "&v=day&mn=" + month + "&yr=" + year + "&dy=" + day 
    Nokogiri::HTML(open("url"))
  end 


end
