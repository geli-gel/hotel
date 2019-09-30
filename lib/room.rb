module Hotel
  class Room
    attr_reader :reservations, :nightly_rate, :number, :blocks
    attr_reader :lists_to_check_status_on
    
    def initialize(rooms_length)
      @reservations = []
      @nightly_rate = 200
      @number = rooms_length + 1
      @blocks = []
      @lists_to_check_status_on = [@reservations, @blocks]
    end

    def status(desired_check_in:, desired_check_out:)
      status = :AVAILABLE
      @lists_to_check_status_on.each do |list|
        list.each do |reservation_or_block|
          if reservation_or_block.date_range_conflict?(desired_check_in, desired_check_out)
            status = :UNAVAILABLE 
            break
          end
        end
      end
      return status
    end

  end
end
