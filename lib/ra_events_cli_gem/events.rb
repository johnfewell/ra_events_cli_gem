# Scrape events from ra for the given city
# events have: title, venue, date, attending number, price, sale close date, line-up, desc

require 'pry'

class RAEventsCliGem::Events
attr_accessor :url, :title, :venue, :attendees, :price, :sale_close, :desc, :lineup

  @@all = []

  def self.new_event(e)
    self.new("https://www.residentadvisor.net/#{e.css("a").attribute("href").text}")
  end

  def initialize(url=nil)
    @url = url
    @@all << self
    @doc ||= Nokogiri::HTML(open(self.url))
  end

  def self.all
    @@all
  end

  def title
    @title =  @doc.xpath("//div[@id='sectionHead']//h1]").text
  end

  def venue
    @venue = (//li[@class='wide']//a)[1]
  end

  def attendees
    @attendees = //h1[@id='MembersFavouriteCount']
  end

  def price
    @price = //li[@id='tickets']//li
  end

  def sale_close
    @sale_close = //p[@id='tickets-info']
  end

  def desc
    @desc = (//div[@class='left']//p)[2]
  end

  def lineup
    @lineup = //p[@class='lineup large']
  end


end
