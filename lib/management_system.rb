module Hotel
  class ManagementSystem
    attr_reader :rooms, :reservations

    def initialize
      @NUMBER_OF_ROOMS = 20
      @rooms = []
      initialize_rooms
    end

    def initialize_rooms
      @NUMBER_OF_ROOMS.times do
        @rooms << Hotel::Room.new(@rooms.length)
      end
    end

    def list_rooms
      return @rooms
    end

    def reservations_for_night(night)
    end

    def create_reservation(check_in_date:, check_out_date:, room_number:)
      room = find_room_by_number(room_number)
      new_reservation = Hotel::Reservation.new(
        check_in_date: check_in_date, 
        check_out_date: check_out_date,
        room: room
        )
    end

    def find_room_by_number(room_number)
      return @rooms.find {|room| room.number == room_number}

    end  

  end
end
