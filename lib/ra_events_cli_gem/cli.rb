class RAEventsCliGem::CLI

  def call
    menu
    goodbye
  end

  def list_cities
    puts <<-DOC
    ██▀███   ▄▄▄       Welcome to the RA Events listing
   ▓██ ▒ ██▒▒████▄     +------------------+------------------+---------------+----------------+
   ▓██ ░▄█ ▒▒██  ▀█▄   | 1. London, UK    | 2. Berlin, DE    | 3. Paris, FR  | 4. Switzerland |
   ▒██▀▀█▄  ░██▄▄▄▄██  | 5. New York, US  | 6. Amsterdam, NL | 7. Tokyo, JP  | 8. Ibiza, ES   |
   ░██▓ ▒██▒ ▓█   ▓██▒ | 9. Barcelona, ES | 10. South + East, UK                              |
   ░ ▒▓ ░▒▓░ ▒▒   ▓▒█░ +----------------------------------------------------------------------+
     ░▒ ░ ▒░  ▒   ▒▒ ░
     ░░   ░   ░   ▒     Choose a city's number to see current events there. (type exit to quit)
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
    @cli_city = {"London, UK" => 1, "Berlin, DE" => 2, "Paris, FR" => 3,
                "Switzerland" => 4, "New York, US" => 5, "Amsterdam, NL" => 6,
                "Tokyo, JP" => 7, "Ibiza, ES" => 8, "Barcelona, ES" => 9,
                "South + East, UK" => 10}
    puts "Choose a date to see the events on that day in #{@cli_city.key(@city.to_i)}."
  end

  def list_events
    if RAEventsCliGem::Events.all.count > 0
      RAEventsCliGem::Events.all.each.with_index(0) do |event, index|
        puts "#{index+1}. #{event.title} at #{event.venue} | #{event.attendees} RA members attending."
      end
    else
      year = @input_date.strftime("%Y")
      month = @input_date.strftime("%m")
      day = @input_date.strftime("%d")
      RAEventsCliGem::Scraper.new.make_events(@city, year, month, day)
      RAEventsCliGem::Events.all.each.with_index(0) do |event, index|
        puts "#{index+1}. #{event.title} at #{event.venue} | #{event.attendees} RA members attending."
      end
    end
  end

  def list_single_event(event_number)
    event = RAEventsCliGem::Events.all[event_number-1]
    puts ""
    puts ""
    puts event.title
    puts "~" * event.title.size
    puts "At #{event.venue}  /  #{event.attendees} RA members attending."
    puts "~" * (event.venue.size + 3) + "     " + "~" * (event.attendees.size + 21)
    puts event.price unless  event.price == ""
    puts "~" * event.price.size unless event.price == ""
    puts "Lineup:"
    puts ""
    puts event.lineup
    puts ""
    puts reformat_wrapped(event.desc)
    puts "+" * 78
  end

  def reformat_wrapped(s, width=78)
	  lines = []
	  line = ""
	  s.split(/\s+/).each do |word|
	    if line.size + word.size >= width
	      lines << line
	      line = word
	    elsif line.empty?
	     line = word
	    else
	     line << " " << word
	   end
	   end
	   lines << line if line
	  return lines.join "\n"
	end

  def menu2
    input = nil
    while input != "exit"
      list_dates
      input = gets.strip.downcase
      if input.to_i.between?(1,14)
        @input_date = @dates[input.to_i-1]
        list_events
        if RAEventsCliGem::Events.all.count == 0
          puts "No events on that date!"
          puts "Press any key to continue"
          gets
          menu2
        else
          menu3
        end
      end
    end
  end

  def menu3
    input = nil
    while input != "exit"
      list_events
      puts "Choose an event number to get more detail, or type exit."
      input = gets.strip.downcase
      if input.to_i.between?(1,RAEventsCliGem::Events.all.count)
        list_single_event(input.to_i)
        puts "Choose 'list' to return to the list, 'date' to search another date in this city, 'start' to restart, or type exit"
        input = gets.strip.downcase
          if input == "list"
            menu3
          elsif input == "date"
            menu2
          elsif input == "start"
            menu
          else
            puts "Not sure what you mean."
            puts "Choose 'list' to return to the list, 'date' to search another date in this city, 'start' to restart, or type exit"
          end
        end
      end
  end

  def menu
    RAEventsCliGem::Events.clear
    list_cities
      input = nil
      while input != "exit"
        input = gets.strip.downcase
        if input.to_i.between?(1,10)
          @city = input.to_i
          menu2
        else
          puts "I don't know what you mean, either type exit or choose a city"
          menu
        end
      end
  end

    def goodbye
      puts <<-DOC
       ______  _____   _____  ______       ______  __   __ _______   /
      |  ____ |     | |     | |     \      |_____]   \_/   |______  /
      |_____| |_____| |_____| |_____/      |_____]    |    |______ .
      DOC
    end

end
