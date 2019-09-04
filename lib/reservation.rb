module Hotel
  class Reservation
    class ReservationError < StandardError; end
    attr_reader :check_in_date, :check_out_date, :room
    def initialize(check_in_date:, check_out_date:, room:)
      @check_in_date = check_in_date
      @check_out_date = check_out_date
      @room = room

      if @check_in_date < Date.today 
        raise ReservationError.new("check_in_date cannot be before today's date")
      elsif @check_out_date < @check_in_date
        raise ReservationError.new("check_out_date cannot be before check_in_date")
      end
      
    end

    def total_cost
      nightly_rate = @room.nightly_rate
      # nightly_rate * #number of nights
    end

  end
end
