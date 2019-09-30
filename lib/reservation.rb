require_relative 'date_range'

module Hotel
  class Reservation < Hotel::DateRange
    class ReservationDateError < StandardError; end
    attr_reader :check_in_date, :check_out_date, :room
    def initialize(check_in_date:, check_out_date:, room:)
      super(check_in_date, check_out_date)
      @room = room

      if @check_in_date < Date.today 
        raise ReservationDateError.new("check_in_date cannot be before today's date")
      elsif @check_out_date < @check_in_date
        raise ReservationDateError.new("check_out_date cannot be before check_in_date")
      end
      
    end

    def total_cost
      nightly_rate = @room.nightly_rate
      return nightly_rate * total_nights
    end

    def total_nights
      return @check_out_date - @check_in_date
    end

    def date_range_conflict?(desired_check_in, desired_check_out)
      super(desired_check_in, desired_check_out)
    end

  end
end
