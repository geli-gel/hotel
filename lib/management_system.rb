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

    def reservations_for_night(night)
    end

    def create_reservation(check_in_date:, check_out_date:, room_number: nil)
    end

  end
end
