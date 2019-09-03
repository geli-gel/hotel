module Hotel
  class ManagementSystem
    attr_reader :rooms, :reservations

    def initialize
      @NUMBER_OF_ROOMS = 20
      # @rooms = initialize_rooms
      # rooms equals array with 20.times management_system.new being pushed in

    end

    def initialize_rooms
      # rooms = []
      # @NUMBER_OF_ROOMS.times do
      #   rooms << Room.new
      # end

    end

    def reservations_for_night(night)
    end

    def create_reservation(check_in_date:, check_out_date:, room_number: nil)
    end

  end
end
