module Hotel
  class ManagementSystem
    attr_reader :rooms, :reservations

    def initialize
      @NUMBER_OF_ROOMS = 20
      @rooms = []
      initialize_rooms
      @reservations = []
    end

    def initialize_rooms
      @NUMBER_OF_ROOMS.times do
        @rooms << Hotel::Room.new(@rooms.length)
      end
    end

    def list_rooms
      return @rooms
    end

    def reservations_by_date(date)
      
    end

    def create_reservation(check_in_date:, check_out_date:)
      new_reservation = Hotel::Reservation.new(
        check_in_date: check_in_date, 
        check_out_date: check_out_date,
        room: choose_room
        )
      @reservations << new_reservation
    end

    def choose_room
      return @rooms.sample
    end  

  end
end
