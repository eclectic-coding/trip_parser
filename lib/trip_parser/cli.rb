# frozen_string_literal: true

module TripParser
  class CLI

    def call
      puts "Hello y'all"
    end

    class TripParser < StandardError
      def message
        puts "You messaged up"
      end
    end
  end
end
