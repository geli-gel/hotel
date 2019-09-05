module Hotel
  class Room
    attr_reader :reservations, :nightly_rate, :number
    
    def initialize(rooms_length)
      @reservations = []
      @nightly_rate = 200
      @number = rooms_length + 1
    end

    def status(desired_check_in:, desired_check_out:)
      status = :AVAILABLE
      @reservations.each do |reservation|
        check_in_conflict = 
          desired_check_in.between?(reservation.check_in_date, 
                                    reservation.check_out_date - 1)
        check_out_conflict = 
          desired_check_out.between?(reservation.check_in_date + 1,
                                     reservation.check_out_date)

        if check_in_conflict || check_out_conflict
          status = :UNAVAILABLE
          break
        end
      end

      return status

    end

  end
end
