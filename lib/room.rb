module Hotel
  class Room
    attr_reader :reservations, :nightly_rate, :room_number
    
    def initialize(rooms_length)
      @reservations = []
      @nightly_rate = 200
      @room_number = rooms_length + 1
    end
  end
end
