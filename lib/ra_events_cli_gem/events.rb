# Scrape events from ra for the given city
# events have: title, venue, date, attending number, price, sale close date, line-up, desc

require 'pry'

class RAEventsCliGem::Events
attr_accessor :url, :title, :venue, :attendees, :price, :desc, :lineup

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

  def self.clear
    @@all.clear
  end

  def title
      @title = @doc.xpath("//div[@id='sectionHead']//h1").text
  end

  def venue
    @venue = @doc.xpath("(//li[@class='wide']//a)[1]").text
  end

  def attendees
    @attendees = @doc.xpath("//h1[@id='MembersFavouriteCount']").text
  end

  def price
    raw_price = @doc.xpath("//li[@id='tickets']//li").text.strip
    replacement_rules = {
    '1st' => ' - 1st',
    '2nd' => ' - 2nd',
    '3rd' => ' - 3rd',
    '4th' => ' - 4th',
    '5th' => ' - 5th',
    'Early' => ' - Early',
    'Extra' => ' - Extra',
    'Final' => ' - Final',
    'Super' => ' - Super',
    'VIP' => ' - VIP',
    'bird' => 'bird. ',
    'release ' => 'release. ',
    'release' => 'release. '
    }
    matcher = /#{replacement_rules.keys.join('|')}/
    @price = raw_price.gsub(matcher, replacement_rules)
  end

  def desc
    @desc = @doc.xpath("(//div[@class='left']//p)[2]").text.strip
  end

  def lineup
    if @doc.xpath("//p[@class='lineup large']").text.strip == ""
      @lineup = @doc.xpath("//p[@class='lineup medium']").text.strip
    else
      @lineup = @doc.xpath("//p[@class='lineup large']").text.strip
    end
  end

end
