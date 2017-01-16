# Ask user what city they want to see evetns in
# Show list of events in that city, Ask if they want to see the detail of any of the events or exit
# Show detail of event, ask if they want to return to the previous menu or exit

class RAEventsCliGem::CLI

  def call

    menu
    #menu
    #menu2
  end

  def list_cities
    puts <<-DOC
    ██▀███   ▄▄▄       Welcome to the RA Events listing
   ▓██ ▒ ██▒▒████▄     +-------------------+----------------+---------------+------------------+----------------------+
   ▓██ ░▄█ ▒▒██  ▀█▄   | 1. London, UK     | 2. Berlin, DE  | 3. Paris, FR  | 4. Switzerland   | 5. New York, US      |
   ▒██▀▀█▄  ░██▄▄▄▄██  | 6. Amsterdam, NL  | 7. Tokyo, JP   | 8. Ibiza, ES  | 9. Barcelona, ES | 10. South + East, UK |
   ░██▓ ▒██▒ ▓█   ▓██▒ +-------------------+----------------+---------------+------------------+-----------+----------+
   ░ ▒▓ ░▒▓░ ▒▒   ▓▒█░
     ░▒ ░ ▒░  ▒   ▒▒ ░
     ░░   ░   ░   ▒
      ░           ░  ░
    DOC
  end

  def list_dates
    @dates = []
    t = Time.now
    @dates << t
    13.times {@dates << t += 86400}
    counter = 1
    @dates.each do |d|
      puts "#{counter}. #{d.strftime("%m/%d/%Y")} #{d.strftime('%A')}"
      counter += 1
    end
    cli_city = {"London, UK" => 1, "Berlin, DE" => 2, "Paris, FR" => 3, "Switzerland" => 4, "New York, US" => 5, "Amsterdam, NL" => 6, "Tokyo, JP" => 7, "Ibiza, ES" => 8, "Barcelona, ES" => 9, "South + East, UK" => 10}
    puts "Choose a date to see the events on that day in #{cli_city.key(@city.to_i)}."
  end

  def list_events
    year = @input_date.strftime("%Y")
    month = @input_date.strftime("%m")
    day = @input_date.strftime("%d")
    RAEventsCliGem::Scraper.new.make_events(@city, year, month, day)
    RAEventsCliGem::Events.all.each.with_index(0) do |event, index|
      puts "#{index+1}. #{event.title} at #{event.venue} | #{event.attendees} RA members attending."
    end
  end

  def list_single_event(event_number)
    event = RAEventsCliGem::Events.all[event_number-1]
    puts ""
    puts event.title
    puts "~" * event.title.size
    puts "At #{event.venue}"
    puts "#{event.attendees} RA members attending."
    puts event.price 
    puts event.sale_close
    puts "Lineup:" 
    puts event.lineup
    puts ""
    puts event.desc 
  end

  def menu
    RAEventsCliGem::Events.clear
    list_cities
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
        if input.to_i > 14
          puts "Must be between 1 and 7"
          menu
        else
          @input_date = @dates[input.to_i-1]
          list_events
        end
      end
        puts "Choose an event number to get more detail, or type exit."
        input = gets.strip.downcase
        if input == "exit"
          exit
        elsif input.to_i.is_a? Integer
          list_single_event(input.to_i)
          input = gets.strip.downcase
          puts "Type list to go back to the list or exit"
          if input == "list"
            list_events
          elsif input == "exit"
            exit
          else
            menu
          end
        end
      end
    end
end
