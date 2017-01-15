# Ask user what city they want to see evetns in
# Show list of events in that city, Ask if they want to see the detail of any of the events or exit
# Show detail of event, ask if they want to return to the previous menu or exit

class RAEventsCliGem::CLI

  def call
    puts "Welcome to the RA Events listing"
    list_cities
    #menu
    #menu2
  end

  def list_cities
    puts "+------------------------------------------------------------------------------------------------------+"
    puts "|1. London, UK        |2. Berlin, DE       |3. Paris, FR       |4. Switzerland   |5. New York, US      |"
    puts "|6. Amsterdam, NL     |7. Tokyo, JP        |8. Ibiza, ES       |9. Barcelona, ES |10. South + East, UK |"
    puts "|11. Manchester, UK   |12. West + Wales, UK|13. Los Angeles, US|14. Ireland      |15. Miami, US        |"
    puts "|16. San Francisco, US|17. Glasgow, UK     |18. Belgium        |19. Edinburgh, UK|20. Chubu, JP        |"
    puts "+------------------------------------------------------------------------------------------------------+"
  end

  def todays_weather(input)
  end

  def ten_day_forecast
    @weather.days_temps
    puts "=---=---=---=---=---=---=---=---=---=---=---="
    puts @weather.week_summary
    puts "=---=---=---=---=---=---=---=---=---=---=---="
    puts @weather.days_array.transpose.map {|x| x.join(" ")}.join("\n")
    puts "=---=---=---=---=---=---=---=---=---=---=---="
  end

  def menu
      input = nil
      while input != "exit"
      puts "Choose a city to see current events there."
      input = gets.strip.downcase
      if input == "exit"
        exit
      else

        todays_weather(input)
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
