module Hotel
  class Reservation
    attr_reader :check_in_date, :check_out_date, :room_number
    def initialize(check_in_date:, check_out_date:, room:)
      @check_in_date = check_in_date
      @check_out_date = check_out_date
      @room = room
      @room_number = room.number
      
    end

    def total_cost
      nightly_rate = @room.nightly_rate
      # nightly_rate * #number of nights
    end

  end
end
