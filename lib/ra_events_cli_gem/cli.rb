# Ask user what city they want to see evetns in
# Show list of events in that city, Ask if they want to see the detail of any of the events or exit
# Show detail of event, ask if they want to return to the previous menu or exit

class RAEventsCliGem::CLI

  def call
    list_cities
    menu
    #menu
    #menu2
  end

  def list_cities
    puts "Welcome to the RA Events listing"
    puts "+------------------------------------------------------------------------------------------------------+"
    puts "|1. London, UK        |2. Berlin, DE       |3. Paris, FR       |4. Switzerland   |5. New York, US      |"
    puts "|6. Amsterdam, NL     |7. Tokyo, JP        |8. Ibiza, ES       |9. Barcelona, ES |10. South + East, UK |"
    puts "+------------------------------------------------------------------------------------------------------+"
  end

  def list_dates
    @dates = []
    t = Time.now
    @dates << t
    6.times {@dates << t += 86400}
    counter = 1
    @dates.each do |d|
      puts "#{counter}. #{d.strftime("%m/%d/%Y")}"
      counter += 1
    end
    puts "Choose a date to see the events on that day in New York"

  end

  def list_events
    year = @input_date.strftime("%Y")
    month = @input_date.strftime("%m")
    day = @input_date.strftime("%d")

    RAEventsCliGem::Scraper.new.make_events(@city, year, month, day)
    # @events = RAEventsCliGem::Events.all(@city, year, month, day)
  end

  def menu
      input = nil
      while input != "exit"
      puts "Choose a city to see current events there. (type exit to quit)"
      input = gets.strip.downcase
      if input == "exit"
        exit
      elsif
        input.to_i > 10
          puts "Must be between 1 and 10"
          menu
      else
        @city = input.to_i
        #send input to scraper and scrape events in given city
        list_dates
        input = gets.strip.downcase
        if input.to_i > 7
          puts "Must be between 1 and 7"
          menu
        else
          @input_date = @dates[input.to_i-1]
          list_events
        end
      end
        puts "Do you want the 8 day forecast for this location? y/n"
        input = gets.strip.downcase
        if input == "y"
          ten_day_forecast
        elsif input == "n"
          puts "Do you want to exit? y/n"
          input = gets.strip.downcase
          if input == "y"
            exit
          else
            menu
          end
        end
      end
    end
end
