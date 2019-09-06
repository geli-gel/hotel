module Hotel
  class ManagementSystem
    class SystemReservationError < StandardError; end
    attr_reader :rooms, :reservations

    def initialize
      @NUMBER_OF_ROOMS = 20
      @rooms = initialize_rooms
      @reservations = []
    end

    def initialize_rooms
      initial_rooms = []
      @NUMBER_OF_ROOMS.times do
        initial_rooms << Hotel::Room.new(initial_rooms.length)
      end
      return initial_rooms
    end

    def list_rooms
      return @rooms
    end

    def reservations_by_date(date)
      return @reservations.select do |reservation|
        date.between?(reservation.check_in_date,reservation.check_out_date)
      end
    end

    def create_reservation(check_in_date:, check_out_date:)
      new_reservation = Hotel::Reservation.new(
        check_in_date: check_in_date, 
        check_out_date: check_out_date,
        room: choose_room(check_in_date, check_out_date)
        )
      @reservations << new_reservation
      new_reservation.room.reservations << new_reservation
    end

    def choose_room(desired_check_in, desired_check_out)
      available_rooms = available_rooms_for(desired_check_in, desired_check_out)
      return available_rooms.sample
    end  
        
    def available_rooms_for(desired_check_in, desired_check_out)
      available_rooms = @rooms.select do |room|
        room.status(desired_check_in: desired_check_in, desired_check_out: desired_check_out) == :AVAILABLE        
      end
      if available_rooms.length > 0
        return available_rooms
      else
        raise SystemReservationError.new("There are no available rooms for the desired_check_in and desired_check_out dates")
      end
    end

  end
end
