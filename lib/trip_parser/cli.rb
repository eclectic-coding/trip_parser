# frozen_string_literal: true

require "time"
require "pry"

module TripParser
  ##
  # Main CLI interface
  #
  class CLI

    def call

      # Output Report
      find_drivers.each do |driver|
        if total_distance(driver).positive?
          puts "#{driver}: #{total_distance(driver)} miles @ #{average_speed(driver)}mph"
        else
          puts "#{driver}: 0 miles"
        end
      end
    end

    def find_drivers
      drivers = []

      File.foreach("input.txt") do |line|
        drivers << line.partition(" ").last.strip if line.partition(" ").first == "Driver"
      end
      drivers.uniq
    end

    def total_distance(driver)
      miles = 0.0

      File.foreach("input.txt") do |trip|
        miles += trip.split(" ")[4].to_f if trip.scan("Trip #{driver.strip}").first
      end

      miles.positive? ? miles : 0
    end

    def average_speed(driver)
      logged_time = 0.0
      File.foreach("input.txt") do |trip|
        if trip.scan("Trip #{driver.strip}").first
          logged_time += (Time.parse(trip.split(" ")[3]) - Time.parse(trip.split(" ")[2])) / 3600
        end
      end
      (total_distance(driver) / logged_time).round
    end

    ##
    # Main TripParser Error
    #
    class TripParser < StandardError; end
  end
end
