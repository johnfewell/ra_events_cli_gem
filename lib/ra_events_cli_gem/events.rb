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
      @title =  @doc.xpath("//div[@id='sectionHead']//h1").text
    #  binding.pry
  end

  def venue
    @venue = @doc.xpath("(//li[@class='wide']//a)[1]").text
  end

  def attendees
    @attendees = @doc.xpath("//h1[@id='MembersFavouriteCount']").text
  end

  def price
    @price = @doc.xpath("//li[@id='tickets']//li").text
  end

  def sale_close
    @sale_close = @doc.xpath("//p[@id='tickets-info']").text
  end

  def desc
    @desc = @doc.xpath("(//div[@class='left']//p)[2]").text.strip
  end

  def lineup
    @lineup = @doc.xpath("//p[@class='lineup large']").text
  end

end
