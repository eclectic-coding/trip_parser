# frozen_string_literal: true

require 'pry'

module TripParser
  ##
  # Main CLI interface
  #
  class CLI

    def call
      puts "Hello y'all"
      # find_drivers
      find_total_distance("Kumi")
    end

    def find_drivers
      drivers = []

      File.foreach("input.txt") do |line|
        drivers << line.partition(" ").last.strip if line.partition(" ").first == "Driver"
      end
      drivers.uniq
    end

    def find_total_distance(driver)
      miles = 0.0
      File.foreach("input.txt") do |trip|
        miles += trip.split(" ")[4].to_f if trip.scan("Trip #{driver.strip}").first
      end

      puts miles.positive? ? miles : 0
    end

    def find_average_trips_speed; end

    def output_report; end

    ##
    # Main TripParser Error
    #
    class TripParser < StandardError; end
  end
end
