# Scrape events from ra for the given city
# events have: title, venue, date, attending number, price, sale close date, line-up, desc

require 'pry'
class RAEventsCliGem::Events
  def now_temp
    @now_temp = @doc.xpath("//span[@class='temp swip']").text
  end
end
